module SessionsHelper
  
  def sign_in(user)
    #cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    #current_user = user
    session[:user_id] = user.id
    self.current_user = user
  end
  
  # Finds the User with the ID stored in the session with the key
  # :current_user_id This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  # logging out removes it.
  def current_user
    @current_user ||= session[:user_id] &&
    User.find_by_id(session[:user_id])
  end
  
  # setter for current user
  def current_user=(user)
    @current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    session[:user_id] = nil
    self.current_user = nil
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private
  
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to] = nil
    end
#    def user_from_remember_token
#      User.authenticate_with_salt(*remember_token)
#    end
#    
#    def remember_token
#      cookies.signed[:remember_token] || [nil, nil]
#    end
end
