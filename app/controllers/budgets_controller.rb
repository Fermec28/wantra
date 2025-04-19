class BudgetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @budget = Budget.new
  end

  def create
    attrs = budget_params.dup
    attrs[:month] = Date.parse("#{attrs[:month]}-01") if attrs[:month].present?
    @budget = current_user.budgets.build(attrs)

    if @budget.save
      @budgets_progress = Budget.where(user: current_user, month: @budget.month.beginning_of_month).map do |budget|
        result = Budgets::Services::BudgetUsageCalculator.new(
          user: current_user,
          tag_name: budget.tag_name,
          month: budget.month,
          currency: budget.amount_currency
        ).call
        result if result.present?
      end.compact

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path, notice: "Presupuesto creado exitosamente." }
      end
    else
      render :new, alert: "Error al crear la cuenta: #{@budget.errors.full_messages.join(', ')}"
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:tag_name, :month, :amount, :amount_currency, :repeat_monthly)
  end
end
