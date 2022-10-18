class Users::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])
    check_validate_user(user)
    redirect_to root_path
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Sign out successfully!"
    redirect_to root_path
  end

  private

  def check_validate_user(user)
    if user&.authenticate(user_params[:password])
      flash[:success] = "Sign in successfully!"
      session[:user_id] = user.id
    elsif user
      flash[:danger] = "Wrong email or password."
    else
      create_new_user
    end
  end

  def create_new_user
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Your account is created successfully"
    else
      flash[:danger] = user.errors.full_messages
    end
  end

  def user_params
    params.require(:users).permit(:email, :password)
  end
end
