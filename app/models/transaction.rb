class Transaction < ApplicationRecord
  # enum txn_kind: { income: "income", expense: "expense", transfer_in: "transfer_in", transfer_out: "transfer_out" }

  belongs_to :user
  belongs_to :account

  has_many :taggings, foreign_key: :tagged_transaction_id
  has_many :tags, through: :taggings

  validates :txn_kind, :amount, :description, :date, presence: true

  scope :transfers, -> { where(txn_kind: [ :transfer_in, :transfer_out ]) }

  monetize :amount_cents, with_model_currency: :amount_currency

  def transfer?
    transfer_in? || transfer_out?
  end
end
