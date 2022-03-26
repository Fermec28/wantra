class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :type
      t.references :acount, null: false, foreign_key: true
      t.decimal :value
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
