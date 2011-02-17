class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
  
  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end
