class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @period = params[:period] || "month"

    data = Dashboards::Queries::DashboardData.new(
      user: current_user,
      period: @period,
      from: params[:from],
      to: params[:to],
      filters: params
    ).call
    # Cards resumen
    @accounts_by_currency = current_user.accounts.group_by(&:balance_currency)
    @period_range = data[:period_range]
    @accounts = data[:accounts]
    @transactions = data[:transactions]
    @summary = data[:summary]
    @tag_distribution_by_currency = data[:tag_distribution_by_currency]
    @top_expense_tags_by_currency = data[:top_expense_tags_by_currency]
    @monthly_summary_chart = data[:monthly_summary_chart]
    @accumulated_chart_data = data[:accumulated_chart_data]
    @budgets_progress = data[:budgets_progress]
  end


  def new
    @transaction = Transaction.new
    @accounts = current_user.accounts
  end

  def create
    txn_kind = params[:transaction][:txn_kind]

    if txn_kind == "transfer"
      command = Transactions::Commands::CreateTransfer.new(
        user_id: current_user.id,
        from_account_id: params[:transaction][:account_id],
        to_account_id: params[:transaction][:to_account_id],
        amount_from: params[:transaction][:amount],
        amount_to: params[:transaction][:amount_to],
        date: params[:transaction][:date],
        description: params[:transaction][:description],
        tag_names: params[:transaction][:tag_list].to_s.split(",").map(&:strip)
      )

      service = Transactions::Services::TransferCreator.new(command)
      service.call
    else
      command = Transactions::Commands::CreateTransaction.new(
        user_id: current_user.id,
        account_id: params[:transaction][:account_id],
        txn_kind: txn_kind,
        amount: params[:transaction][:amount],
        description: params[:transaction][:description],
        date: params[:transaction][:date],
        tag_names: params[:transaction][:tag_list].map(&:strip)
      )

      service = Transactions::Services::TransactionCreator.new(command)
      service.call
    end

    redirect_to transactions_path, notice: "Transacción creada con éxito."
  rescue => e
    redirect_to transactions_path, alert: "Error al crear transacción: #{e.message}"
  end
end
