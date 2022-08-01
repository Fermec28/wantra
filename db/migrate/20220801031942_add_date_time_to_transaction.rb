# frozen_string_literal: true

class AddDateTimeToTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :datetime, :datetime
  end
end
