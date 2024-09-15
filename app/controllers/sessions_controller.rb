class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
    else
      flash.now[:warning] = "Invalid email/password combination"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
  end
end