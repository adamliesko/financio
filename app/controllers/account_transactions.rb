class AccountTransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.json { render json: @transactions }
    end
  end

  def create

  end

  private

  def account
    @account ||= user.accounts.find(params[:agenda_id])
  end

  def user
    current_user
  end

  def invoices
    @transactions = account.transactions
  end
end