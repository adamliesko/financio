class UserLoginsController < ApplicationController
  before_action :authenticate_user!

  def index
    user_logins
  end

  private

  def user_logins
    @user_logins ||= current_user.logins
  end
end
