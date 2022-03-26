class CreateAcounts < ActiveRecord::Migration[6.1]
  def change
    create_table :acounts do |t|
      t.string :name
      t.string :description
      t.references :currency, null: false, foreign_key: true
      t.decimal :total_amount

      t.timestamps
    end
  end
end
