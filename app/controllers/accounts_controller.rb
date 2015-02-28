class AccountsController < ApplicationController
  before_filter :authenticate_user!

  def index
    accounts
    @account = Account.new
  end

  def create
    @account = Account.new(account_params.merge(user_id: current_user.id))
    @account.save
    redirect_to @account
  end

  def show
    account
  end

  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content } # 204 No Content
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def account
    @account ||= accounts.find(params[:id])
  end


  def accounts
    @accounts = current_user.accounts
  end

  def account_params
    params.require(:account).permit(:name, :critical_value, :send_notifications)
  end
end