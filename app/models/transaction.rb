# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account

  enum type: %i[incoming expense transfer_incoming transfer_expense]
end
