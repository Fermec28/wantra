module Transactions
  module Commands
    class CreateTransaction
      attr_reader :user_id, :account_id, :txn_kind, :amount, :description, :date, :tag_names, :transfer_group_id

      def initialize(user_id:, account_id:, txn_kind:, amount:, description:, date:, tag_names:, transfer_group_id: nil)
        @user_id = user_id
        @account_id = account_id
        @txn_kind = txn_kind
        @amount = amount
        @description = description
        @date = date
        @tag_names = tag_names
        @transfer_group_id = transfer_group_id
      end
    end
  end
end
