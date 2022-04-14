class Api::V1::AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    # must to be filtered by user
    @accounts = Account.all
    render json: @accounts
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    if @account
      render json: @account
    else
      render json: @account.errors
    end
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(beer_params)

    if @account.save
      render json: @account
    else
      render json: @account.errors
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy

    render json: { notice: 'Account was successfully removed.' }
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.permit(:name, :description, :total_amount, :currency)
  end
end
