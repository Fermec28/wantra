class RemoveOldAmountAndBalance < ActiveRecord::Migration[8.0]
  def change
    remove_column :accounts, :balance, :decimal
    remove_column :accounts, :currency, :string
    remove_column :transactions, :amount, :decimal
  end
end
