# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApplicationController
      before_action :set_account, only: %i[show edit update destroy]

      def index
        # must to be filtered by user
        @accounts = Account.all
        render json: AccountBlueprint.render(@accounts)
      end

      # GET /accounts/1
      # GET /accounts/1.json
      def show
        if @account
          render json: AccountBlueprint.render(@account)
        else
          render json: @account.errors
        end
      end

      # POST /accounts
      # POST /accounts.json
      def create
        @account = Account.new(account_params)
        if @account.save
          render json: AccountBlueprint.render(@account), status: :created
        else
          render json: { errors: @account.errors }
        end
      end

      # PATCH/PUT /accounts/1
      # PATCH/PUT /accounts/1.json
      def update; end

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
        params.require(:account).permit(:name, :description, :total_amount, :currency_id)
      end
    end
  end
end
