class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :transactions, through: :taggings, source: :tagged_transaction
  validates :name, presence: true
end
