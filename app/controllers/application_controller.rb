class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :currently_signed_in?, :current_user_is_admin, :ensure_that_signed_in, :ensure_that_is_admin
  
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
  
  def ensure_that_signed_in 
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end
  
  def ensure_that_is_admin
  	redirect_to :back, notice:'you should admin' if !current_user_is_admin
  end 
  
  def current_user_is_admin
  	user = current_user
  	if(user.nil?)
  		return false
  	end
  	return user.admin
  end
end
