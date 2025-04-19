class BudgetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @budget = Budget.new
  end

  def create
    result = Budgets::Services::BudgetCreator.new(user: current_user, params: budget_params).call
    @budget = result.budget
    if result.success?
      @budgets_progress = Budget.where(user: current_user, month: @budget.month.beginning_of_month).map do |budget|
        Budgets::Services::BudgetUsageCalculator.new(
          user: current_user,
          tag_id: @budget.tag_id,
          month: @budget.month,
          currency: @budget.amount_currency
        ).call
      end.compact

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path, notice: t(".success") }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :new, status: :unprocessable_entity }
        format.html         { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:month, :amount, :amount_currency, :repeat_monthly, :tag_name)
  end
end
