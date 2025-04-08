require 'rails_helper'

RSpec.describe Transactions::Services::TransactionCreator do
  describe "#call" do
    let(:user) { User.create!(email: "test@example.com", password: "password") }
    let(:account) { Account.create!(user: user, name: "Cuenta Prueba", currency: "USD", balance: 100.0) }

    let(:command) do
      Transactions::Commands::CreateTransaction.new(
        user_id: user.id,
        account_id: account.id,
        txn_kind: "expense",
        amount: 42.50,
        description: "Comida",
        date: Date.today,
        tag_names: [ "comida", "restaurante" ]
      )
    end

    it "crea la transacción y actualiza el balance de la cuenta" do
      expect {
        described_class.new(command).call
      }.to change { account.reload.balance }.by(-42.50)

      transaction = user.transactions.last

      expect(transaction.amount).to eq(42.50)
      expect(transaction.txn_kind).to eq("expense")
      expect(transaction.tags.map(&:name)).to include("comida", "restaurante")
    end
  end
end
