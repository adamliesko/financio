class AccountTransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    transactions
    respond_to do |format|
      format.json { render json: @transactions, methods: :category_name }
    end
  end

  def create
    category = Category.find_or_create_by(name:
                                            params[:account_transaction][:category])
    @transaction = AccountTransaction.new(transaction_params.merge(
                                            account_id: params[:account_id], category: category))
    if @transaction.save
      redirect_to account,
                  notice: 'An transaction hass been added to your account.'
    else
      redirect_to account,
                  notice: 'Your transaction has not been added, sorry :('
    end
  end

  private

  def account
    @account ||= user.accounts.find(params[:account_id])
  end

  def user
    current_user
  end

  def transactions
    @transactions = account.account_transactions
    @transactions = @transactions.where(transaction_date: Date.strptime(params[:date_from], '%m/%d/%Y')..Date.strptime(params[:date_to], '%m/%d/%Y')) if params[:date_to].present? && params[:date_from].present?
  end

  def transaction_params
    params.require(:account_transaction).permit(:subject, :value, :purpose, :transaction_date, :category)
  end
end
