module Transactions
  module Services
    class TransactionCreator
      def initialize(command)
        @command = command
      end

      def call
        ActiveRecord::Base.transaction do
          tags = find_or_create_tags(@command.user_id, @command.tag_names)
          account = Account.find_by!(id: @command.account_id, user_id: @command.user_id)
          transaction = ::Transaction.create!(
            user_id: @command.user_id,
            account_id: @command.account_id,
            txn_kind: @command.txn_kind,
            amount: @command.amount,
            amount_currency: account.balance_currency,
            description: @command.description,
            date: @command.date
          )

          tags.each do |tag|
            Tagging.create!(tagged_transaction: transaction, tag: tag)
          end

          update_account_balance!(transaction)

          transaction
        end
      end

      private

      def find_or_create_tags(user_id, names)
        names.map do |name|
          Tag.find_or_create_by!(user_id: user_id, name: name.strip.downcase)
        end
      end

      def update_account_balance!(transaction)
        account = transaction.account

        case transaction.txn_kind
        when "income", "transfer_in"
          account.increment!(:balance_cents, transaction.amount.cents)
        when "expense", "transfer_out"
          account.decrement!(:balance_cents, transaction.amount.cents)
        end
      end
    end
  end
end
