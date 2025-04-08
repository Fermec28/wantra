class AddMonetizeToAccounts < ActiveRecord::Migration[8.0]
  def change
    add_monetize :accounts, :balance, currency: { present: true }
  end
end
