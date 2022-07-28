class AccountBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :description
  field :total_amount, name: :amount
  association :currency, blueprint: CurrencyBlueprint
end
