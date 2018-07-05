# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  # showing user list
  def index
    authorize! :read, :Secretary, :User, :Canteen
    @users = User.all
  end

  # showing user profile page
  def show
    @user = User.find(params[:id])
    authorize! :read, @user.type.to_sym
  end

  # deleting a user
  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user.type.to_sym
    @user.destroy
    flash[:notice] = 'User deleted'
    redirect_to users_path
  end

  # editing a user
  def edit
    @user = User.find(params[:id])
    authorize! :update, @user.type.to_sym
  end

  # updating a user
  def update
    @user = User.find(params[:id])
    authorize! :update, @user.type.to_sym
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
