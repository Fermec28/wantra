module Transactions
  module Commands
    class CreateTransfer
      attr_reader :user_id, :from_account_id, :to_account_id,
                  :amount_from, :amount_to, :date, :description, :tag_names

      def initialize(user_id:, from_account_id:, to_account_id:, amount_from:, amount_to:, date:, description:, tag_names:)
        @user_id = user_id
        @from_account_id = from_account_id
        @to_account_id = to_account_id
        @amount_from = amount_from.to_d
        @amount_to = amount_to.to_d
        @date = date
        @description = description
        @tag_names = tag_names
      end
    end
  end
end
