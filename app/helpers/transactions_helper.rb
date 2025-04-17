module TransactionsHelper
  def show_onboarding_checklist?
    current_user.accounts.empty? ||
      current_user.transactions.empty? ||
      current_user.tags.empty? ||
      current_user.budgets.empty?
  end
end
