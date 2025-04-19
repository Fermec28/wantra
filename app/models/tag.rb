class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :transactions, through: :taggings, source: :tagged_transaction
  validates :name, presence: true, uniqueness: { scope: :user_id }
  before_validation :normalize_name


  private
  def normalize_name
    self.name = name.to_s.strip.downcase
  end
end
