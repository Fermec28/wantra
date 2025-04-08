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
      redirect_to transactions_path, notice: "Presupuesto creado con éxito."
    else
      render :new, alert: "Error al crear la cuenta: #{@budget.errors.full_messages.join(', ')}"
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:tag_name, :month, :amount, :amount_currency, :repeat_monthly)
  end
end
