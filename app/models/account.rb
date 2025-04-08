class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  monetize :balance_cents, with_model_currency: :balance_currency
  validates :name, :balance_currency, presence: true
  validate :currency_is_immutable, on: :update

  def currency_is_immutable
    if balance_currency_changed?
      errors.add(:currency, "No se puede cambiar una vez creada la cuenta")
    end
  end
end
