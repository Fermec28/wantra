class CreateBudgets < ActiveRecord::Migration[8.0]
  def change
    create_table :budgets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :tag_name, null: false
      t.date :month, null: false
      t.monetize :amount, currency: { present: true }
      t.boolean :repeat_monthly, default: false

      t.timestamps
    end

    add_index :budgets, [ :user_id, :tag_name, :month, :amount_currency ], unique: true
  end
end
