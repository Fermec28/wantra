class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @period = params[:period] || "month"

    @period_range =
      case @period
      when "week"
        Date.today.beginning_of_week..Date.today
      when "year"
        Date.today.beginning_of_year..Date.today
      when "custom"
        from = params[:from].presence && Date.parse(params[:from])
        to   = params[:to].presence && Date.parse(params[:to])
        from..to if from && to
      else
        Date.today.beginning_of_month..Date.today
      end

    base = current_user.transactions.includes(:tags, :account)
    @accounts = current_user.accounts
    @transactions = Transactions::Queries::TransactionFilter.new(base, params).call.order(date: :desc)

    # Cards resumen
    @accounts_by_currency = current_user.accounts.group_by(&:balance_currency)

    @summary = {
      expenses: current_user.transactions
        .includes(:account)
        .where(txn_kind: "expense", date: @period_range)
        .group_by { |t| t.account.balance_currency }
        .transform_values { |txns| txns.sum(&:amount) },

      incomes: current_user.transactions
        .includes(:account)
        .where(txn_kind: "income", date: @period_range)
        .group_by { |t| t.account.balance_currency }
        .transform_values { |txns| txns.sum(&:amount) },

      count: current_user.transactions
        .where(date: @period_range)
        .count
    }

    @top_expense_tags_by_currency = @transactions
      .includes(:account, :tags)
      .where(txn_kind: "expense", date: @period_range)
      .flat_map do |t|
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

    @tag_distribution_by_currency = @transactions
      .includes(:account, :tags)
      .where(txn_kind: "expense", date: @period_range)
      .flat_map do |t|
        t.tags.map do |tag|
          currency = t.account.balance_currency
          name     = tag.name.presence || "Sin etiqueta"
          amount   = t.amount.to_f
          [ currency, name, amount ]
        end
      end
      .group_by { |currency, _, _| currency }
      .transform_values do |entries|
        entries.group_by { |_, tag, _| tag }
               .transform_values { |tag_entries| tag_entries.sum { |_, _, amount| amount } }
               .sort_by { |_, amount| -amount }
               .to_h
      end
    # Comparación mensual de ingresos/gastos
    @monthly_summary_chart = @transactions
      .includes(:account)
      .where(date: 12.months.ago.beginning_of_month..Date.today.end_of_month)
      .where(txn_kind: [ "income", "expense" ])
      .group_by { |t| [ t.date.strftime("%b %Y"), t.account.balance_currency, t.txn_kind ] }
      .each_with_object(Hash.new { |h, k| h[k] = {} }) do |((month, currency, kind), txns), hash|
        label = "#{currency} - #{kind == 'income' ? 'Ingresos' : 'Gastos'}"
        hash[label][month] = txns.sum(&:amount).to_f
      end

    # Transform to format that works for column_chart
    @monthly_summary_chart = @monthly_summary_chart.map do |name, data|
      { name: name, data: data }
    end
    @accumulated_chart_data = @transactions
      .includes(:account)
      .where(date: @period_range)
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
          data: data
        }
    end

    @budgets_progress = Budget.where(user: current_user, month: @period_range.first.beginning_of_month).map do |budget|
      result = Budgets::Services::BudgetUsageCalculator.new(
        user: current_user,
        tag_name: budget.tag_name,
        month: budget.month,
        currency: budget.amount_currency
      ).call

      result if result.present?
    end.compact
  end

  def new
    @transaction = Transaction.new
    @accounts = current_user.accounts
  end

  def create
    txn_kind = params[:transaction][:txn_kind]

    if txn_kind == "transfer"
      command = Transactions::Commands::CreateTransfer.new(
        user_id: current_user.id,
        from_account_id: params[:transaction][:account_id],
        to_account_id: params[:transaction][:to_account_id],
        amount_from: params[:transaction][:amount],
        amount_to: params[:transaction][:amount_to],
        date: params[:transaction][:date],
        description: params[:transaction][:description],
        tag_names: params[:transaction][:tag_list].to_s.split(",").map(&:strip)
      )

      service = Transactions::Services::TransferCreator.new(command)
      service.call
    else
      command = Transactions::Commands::CreateTransaction.new(
        user_id: current_user.id,
        account_id: params[:transaction][:account_id],
        txn_kind: txn_kind,
        amount: params[:transaction][:amount],
        description: params[:transaction][:description],
        date: params[:transaction][:date],
        tag_names: params[:transaction][:tag_list].map(&:strip)
      )

      service = Transactions::Services::TransactionCreator.new(command)
      service.call
    end

    redirect_to transactions_path, notice: "Transacción creada con éxito."
  rescue => e
    redirect_to transactions_path, alert: "Error al crear transacción: #{e.message}"
  end
end
