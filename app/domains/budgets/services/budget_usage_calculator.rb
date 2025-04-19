module Budgets
  module Services
    class BudgetUsageCalculator
      def initialize(user:, tag_id:, month:, currency:)
        @user = user
        @tag_id = tag_id
        @tag_name = user.tags.find_by(id: tag_id)&.name
        @month = month.beginning_of_month
        @currency = currency
      end

      def call
        budget = Budget.find_by(
          user: @user,
          tag_id: @tag_id,
          month: @month,
          amount_currency: @currency
        )

        return nil unless budget

        spent = @user.transactions
          .joins(:account, :tags)
          .where(
            txn_kind: "expense",
            date: @month..@month.end_of_month,
            accounts: { balance_currency: @currency },
            tags: { id: @tag_id }
          )
          .distinct
          .sum(:amount_cents)

          spent = Money.new(spent, @currency)

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
