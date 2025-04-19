module Dashboards
  module Queries
    class DashboardData
      attr_reader :user, :period, :from, :to

      def initialize(user:, period:, from: nil, to: nil, filters: nil)
        @user = user
        @period = period
        @from = from
        @to = to
        @filters = filters
      end

      def call
        {
          period_range:,
          accounts: @user.accounts,
          transactions:,
          summary: summary_data,
          tag_distribution_by_currency:,
          top_expense_tags_by_currency:,
          monthly_summary_chart:,
          accumulated_chart_data:,
          budgets_progress:
        }
      end

      private

      def period_range
        @period_range ||= case @period
        when "week"
          Date.today.beginning_of_week..Date.today
        when "year"
          Date.today.beginning_of_year..Date.today
        when "custom"
          from = @from.presence && Date.parse(@from)
          to   = @to.presence && Date.parse(@to)
          from..to if from && to
        else
          Date.today.beginning_of_month..Date.today
        end
      end

      def transactions
        @transactions ||= begin
          base = user.transactions.includes(:account, :tags)
          scoped = Transactions::Queries::TransactionFilter.new(base, @filters).call
          scoped.where(date: period_range)
        end
      end

      def summary_data
        {
          expenses: group_and_sum_by_currency("expense"),
          incomes: group_and_sum_by_currency("income"),
          count: transactions.count
        }
      end

      def group_and_sum_by_currency(kind)
        transactions
          .select { |t| t.txn_kind == kind }
          .group_by { |t| t.account.balance_currency }
          .transform_values { |txns| txns.sum(&:amount) }
      end

      def tag_distribution_by_currency
        group_tag_data("expense")
      end

      def top_expense_tags_by_currency
        group_tag_data("expense")
      end

      def group_tag_data(kind)
        scope = kind == :all ? transactions : transactions.select { |t| t.txn_kind == kind }

        scope.flat_map do |t|
          t.tags.map do |tag|
            currency = t.account.balance_currency
            name     = tag.name.presence || "Sin etiqueta"
            amount   = t.amount.to_f
            [ currency, name, amount ]
          end
        end
        .group_by { |currency, _, _| currency }
        .transform_values do |entries|
          entries
            .group_by { |_, tag, _| tag }
            .transform_values { |tag_entries| tag_entries.sum { |_, _, amount| amount } }
            .sort_by { |_, amount| -amount }
            .to_h
        end
      end

      def monthly_summary_chart
        data = transactions
          .includes(:account)
          .where(date: 12.months.ago.beginning_of_month..Date.today.end_of_month)
          .where(txn_kind: [ "income", "expense" ])
          .group_by { |t| [ t.date.beginning_of_month.strftime("%b %Y"), t.account.balance_currency, t.txn_kind ] }
          .each_with_object(Hash.new { |h, k| h[k] = {} }) do |((month, currency, kind), txns), hash|
            label = "#{currency} - #{kind == 'income' ? 'Ingresos' : 'Gastos'}"
            hash[label][month] = txns.sum(&:amount).to_f
          end
        data.map do |name, data|
          { name: name, data: data }
        end
      end

      def accumulated_chart_data
        transactions
          .group_by { |t| [ t.account.balance_currency, t.txn_kind, t.date ] }
          .group_by { |(currency, kind, _), _| [ currency, kind ] }
          .map do |(currency, kind), entries|
            sorted = entries
              .map { |(_, _, date), txns| [ date, txns.sum(&:amount).to_f ] }
              .sort_by(&:first)

            accumulated = 0
            data = sorted.map do |date, amount|
              accumulated += amount
              [ date, accumulated.round(2) ]
            end

            {
              name: "#{currency} - #{kind == 'income' ? 'Ingresos' : 'Gastos'}",
              data:
            }
          end
      end

      def budgets_progress
        Budget.where(user: @user, month: period_range.first.beginning_of_month).map do |budget|
          Budgets::Services::BudgetUsageCalculator.new(
            user: @user,
            tag_id: budget.tag_id,
            month: budget.month,
            currency: budget.amount_currency
          ).call
        end.compact
      end
    end
  end
end
