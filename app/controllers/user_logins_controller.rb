class UserLoginsController < ApplicationController
  before_filter :authenticate_user!

  def index
    user_logins
  end



  private

  def user_logins
    @user_logins ||= current_user.logins
  end

end