class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "#{@user.email} has successfully logged in"
      redirect_to root_path
    else
      flash[:error] = "User Email or Password invalid"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to signup_path
  end
end
