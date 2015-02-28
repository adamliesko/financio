class AccountTransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    transactions
    respond_to do |format|
      format.json { render :json => @transactions, :methods => :category_name}
    end
  end

  def create
    account_transaction = AccountTransaction.new(account_transaction_params)
    if account_transaction.save
      redirect_to account, :notice => "Transaction added"
    else
      redirect_to account, :notice => "Your transaction has not been added, sorry :("
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
  end
end