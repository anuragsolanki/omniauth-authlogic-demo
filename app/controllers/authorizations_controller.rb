class AuthorizationsController < ApplicationController
  
  def create
    omniauth = request.env['omniauth.auth'] #this is where you get all the data from your provider through omniauth
    @auth = Authorization.find_from_hash(omniauth)
    if current_user
      current_user.authorizations.create(:provider => omniauth['provider'], :uid => omniauth['uid']) #Add an auth to existing user
      flash[:notice] = "Successfully added #{omniauth['provider']} authentication"
    elsif @auth
      UserSession.create(@auth.user, true) #User is present. Login the user with his social account
      flash[:notice] = "Welcome back #{omniauth['provider']} user"
    else  
      @new_auth = Authorization.create_from_hash(omniauth, current_user) #Create a new user
      UserSession.create(@new_auth.user, true) #Log the authorizing user in.
      flash[:notice] = "Welcome #{omniauth['provider']} user. Your account has been created."
      
      # user = User.new
      # user.apply_omniauth(omniauth)
      # if user.save
      #   flash[:notice] = "Signed in successfully."
      #   sign_in_and_redirect(:user, user)
      # else
      #   session[:omniauth] = omniauth.except('extra')
      #   redirect_to new_user_path
      # end
    end
    redirect_to root_url
  end
  
  def failure
    flash[:notice] = "Sorry, You did not authorize."
    redirect_to root_url
  end
  
  def destroy
    @authorization = current_user.authorizations.find(params[:id])
    @authorization.destroy
    flash[:notice] = "Successfully deleted #{@authorization.provider} authentication."
    redirect_to root_url
  end
  
end
