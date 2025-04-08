class AddMonetizeToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_monetize :transactions, :amount, currency: { present: true }
  end
end
