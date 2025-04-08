class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  monetize :balance_cents, with_model_currency: :balance_currency
  validates :name, :balance_currency, presence: true
end
