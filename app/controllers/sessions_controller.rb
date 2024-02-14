class SessionsController < ApplicationController
    def create
      @user = User.find_by(username: params[:username])
  
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        # Error message on failure
        message = "Invalid username or password"
        redirect_to login_path, notice: message
      end
    end
  end
  