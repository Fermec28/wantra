class AddBalanceToAccounts < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :balance, :decimal, default: 0.0, null: false
  end
end
