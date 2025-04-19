class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  monetize :amount_cents, with_model_currency: :amount_currency

  validates :month, presence: true
  validates :amount_cents, presence: true
  validates :amount_currency, presence: true

  validates :user_id, uniqueness: {
    scope: [ :tag_id, :month, :amount_currency ],
    message: "ya tiene un presupuesto para esa categoría, mes y moneda"
  }

  scope :for_month, ->(date) {
    where(month: date.beginning_of_month)
  }

  def self.for_user_and_month(user, tag_name, date)
    where(user: user, tag_name: tag_name, month: date.beginning_of_month).first
  end

  def remaining_amount(spent)
    amount - spent
  end

  def exceeded?(spent)
    spent > amount
  end
end
