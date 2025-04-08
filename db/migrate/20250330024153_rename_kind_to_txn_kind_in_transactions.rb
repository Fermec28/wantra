class RenameKindToTxnKindInTransactions < ActiveRecord::Migration[8.0]
  def change
    rename_column :transactions, :kind, :txn_kind
  end
end
