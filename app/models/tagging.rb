class Tagging < ApplicationRecord
  belongs_to :tagged_transaction, class_name: "Transaction"
  belongs_to :tag
end
