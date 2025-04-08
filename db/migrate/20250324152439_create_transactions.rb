class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.string :kind
      t.decimal :amount
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
