# frozen_string_literal: true

class AddCodeToCurrencies < ActiveRecord::Migration[6.1]
  def change
    add_column :currencies, :code, :string
  end
end
