module Budgets
  module Services
    class BudgetUsageCalculator
      def initialize(user:, tag_name:, month:, currency:)
        @user = user
        @tag_name = tag_name.downcase.strip
        @month = month.beginning_of_month
        @currency = currency
      end

      def call
        budget = Budget.find_by(
          user: @user,
          tag_name: @tag_name,
          month: @month,
          amount_currency: @currency
        )

        return nil unless budget

        spent = @user.transactions
          .includes(:tags, :account)
          .where(txn_kind: "expense", date: @month..@month.end_of_month)
          .select { |t| t.account.balance_currency == @currency && t.tags.map(&:name).include?(@tag_name) }
          .sum(&:amount)

        {
          budget: budget.amount,
          spent: spent,
          remaining: budget.remaining_amount(spent),
          exceeded: budget.exceeded?(spent),
          currency: @currency,
          tag_name: @tag_name,
          month: @month
        }
      end
    end
  end
end
