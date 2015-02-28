class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :invalidate_simultaneous_user_session,
                unless: proc { |request| request.controller_name == 'sessions' && request.action_name == 'create' }

  def invalidate_simultaneous_user_session
    if current_user && session[:sign_in_token] != current_user.current_sign_in_token
      scope = Devise::Mapping.find_scope!(current_user)
      redirect_path = after_sign_out_path_for(scope)
      Devise.sign_out_all_scopes ? sign_out : sign_out(scope)
      redirect_to redirect_path,
                  alert: 'Your session has been invalidated because you have logged in from somewhere else.'
    end
  end
end
