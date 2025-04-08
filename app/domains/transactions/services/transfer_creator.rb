module Transactions
  module Services
    class TransferCreator
      def initialize(command)
        @command = command
      end

      def call
        from = find_user_account!(@command.from_account_id)
        to   = find_user_account!(@command.to_account_id)

        raise ArgumentError, "No se puede transferir entre la misma cuenta" if from.id == to.id

        amount_from = @command.amount_from.to_d
        amount_to =
          if from.balance_currency == to.balance_currency
            amount_from
          else
            raise ArgumentError, "Debe indicar el monto destino" unless @command.amount_to
            @command.amount_to.to_d
          end

        transfer_group_id = SecureRandom.uuid

        from_tx = Transactions::Commands::CreateTransaction.new(
          user_id: @command.user_id,
          account_id: from.id,
          txn_kind: "transfer_out",
          amount: amount_from,
          description: @command.description,
          date: @command.date,
          tag_names: @command.tag_names,
          transfer_group_id: transfer_group_id
        )

        to_tx = Transactions::Commands::CreateTransaction.new(
          user_id: @command.user_id,
          account_id: to.id,
          txn_kind: "transfer_in",
          amount: amount_to,
          description: @command.description,
          date: @command.date,
          tag_names: @command.tag_names,
          transfer_group_id: transfer_group_id
        )

        ActiveRecord::Base.transaction do
          out = Transactions::Services::TransactionCreator.new(from_tx).call
          Transactions::Services::TransactionCreator.new(to_tx).call
          out
        end
      end

      private

      def find_user_account!(id)
        Account.find_by!(id: id, user_id: @command.user_id)
      end
    end
  end
end
