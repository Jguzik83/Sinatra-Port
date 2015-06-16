class UsersController < ApplicationController

  #GET signup
  def signup
    @user = User.new
  end

  #POST signup
  def create
    p params
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
    end
    redirect_to root_path
  end

  #GET login
  def login
    @user = User.new
  end

  #POST login
  def create_session
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.password == params[:user][:password]
      session[:user_id] = @user.id
    end
    redirect_to root_path
  end

  #DELETE logout
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
