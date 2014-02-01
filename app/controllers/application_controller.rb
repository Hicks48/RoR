class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :currently_signed_in?
  
  def current_user
  	if(session[:user_id] == nil)
  		return nil
  	end
  	return User.find(session[:user_id])
  end
  
  def currently_signed_in?(user)
  	if(user == nil || current_user == nil)
  		return false
  	end
  	return user.id == current_user.id
  end
end
