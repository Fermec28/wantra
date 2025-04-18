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
      respond_to do |format|
        format.turbo_stream do
          @accounts = current_user.accounts
          format.turbo_stream
        end
        format.html { redirect_to root_path, notice: "Cuenta creada exitosamente" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :new, status: :unprocessable_entity }
        format.html         { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @account = current_user.accounts.find(params[:id])

    if @account.update(account_update_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to accounts_path, notice: "Cuenta actualizada." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :balance_currency)
  end

  def account_update_params
    params.require(:account).permit(:name)
  end
end
