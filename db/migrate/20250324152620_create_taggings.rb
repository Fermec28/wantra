class CreateTaggings < ActiveRecord::Migration[8.0]
  def change
    create_table :taggings do |t|
      t.references :tagged_transaction, null: false, foreign_key: { to_table: :transactions }
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
