class AddTagToBudgets < ActiveRecord::Migration[7.1]
  def change
    add_reference :budgets, :tag, foreign_key: true, index: true

    reversible do |dir|
      dir.up do
        Budget.reset_column_information
        Budget.find_each do |budget|
          next if budget.tag_name.blank?

          tag = Tag.find_or_create_by(name: budget.tag_name.strip.downcase, user_id: budget.user_id)
          budget.update_column(:tag_id, tag.id)
        end
      end
    end

    remove_column :budgets, :tag_name
  end
end
