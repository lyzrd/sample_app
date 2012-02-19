class SessionsController < ApplicationController
  
  def new
    @title = "Sign in"
  end
  
  # "Create" a login, aka "log the user in"
  def create
    user = User.authenticate(params[:session][:email],params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    @_current_user = session[:current_user_id] = nil
    redirect_to root_path
  end
end
