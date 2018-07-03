# frozen_string_literal: true

class UsersController < ApplicationController
  # showing user list
  def index
    @users = User.all
  end

  # showing user profile page
  def show
    @user = User.find(params[:id])
  end

  # deleting a user
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = 'User deleted'
    redirect_to users_path
  end

  # editing a user
  def edit
    @user = User.find(params[:id])
  end

  # updating a user
  def update
    @user = User.find(params[:id])
    data = params.require(:user).permit(:first_name, :last_name, :username, :email)
    res = @user.update(data)
    if res
      flash[:notice] = 'User updated'
    else
      flash[:warning] = "Can't update user, email invalid or already in use"
    end
    redirect_to edit_user_path(@user)
  end
end
