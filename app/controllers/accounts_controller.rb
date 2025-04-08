class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = Account.new
  end

  def create
    @account = current_user.accounts.new(account_params)
    if @account.save
      redirect_to accounts_path, notice: "Cuenta creada exitosamente"
    else
      render :new, alert: "Error al crear la cuenta"
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :balance_currency)
  end
end
