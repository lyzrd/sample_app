module SessionsHelper
  
  def sign_in(user)
    #cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    #current_user = user
    session[:current_user_id] = user.id
  end
  
  # Finds the User with the ID stored in the session with the key
  # :current_user_id This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  # logging out removes it.
  def current_user
    @_current_user ||= session[:current_user_id] &&
    User.find_by_id(session[:current_user_id])
  end
  
  # setter for current user
  def current_user=(user)
    @current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end
  
  private
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
