class Transaction < ApplicationRecord
  belongs_to :acount
  belongs_to :category

  enum type: {
    incoming: 0,
    expense: 1,
    transfer_incoming: 2,
    transfer_expense: 3
  }
end