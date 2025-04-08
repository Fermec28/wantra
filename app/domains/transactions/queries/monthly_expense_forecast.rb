module Transactions
  module Queries
    class MonthlyExpenseForecast
      def initialize(user, date = Date.today)
        @user = user
        @date = date
      end

      def call
        start_of_month = @date.beginning_of_month
        end_of_month   = @date.end_of_month
        days_passed    = (@date - start_of_month).to_i + 1
        total_days     = end_of_month.day

        return {} if days_passed.zero?

        transactions = @user.transactions
          .includes(:account)
          .where(txn_kind: "expense", date: start_of_month..@date)

        transactions.group_by { |t| t.account.balance_currency }.transform_values do |txns|
          actual = txns.sum(&:amount)
          daily_avg = actual / days_passed.to_f
          forecast = daily_avg * total_days

          {
            actual: actual,
            forecast: forecast.round(2)
          }
        end
      end
    end
  end
end
