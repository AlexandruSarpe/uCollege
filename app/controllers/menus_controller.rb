# frozen_string_literal: true
class MenusController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :crud, :Menu
  end

  def indexAll
    authorize! :read, :Menu
  end

  def new
    authorize! :create, :Menu
    @menu=Menu.create
  end

  def edit
    authorize! :update, :Menu
    @menu = Menu.find(params[:id])
  end

  def show
    authorize! :read, :Menu
    @menu = Menu.find(params[:id])
  end

  def create
    authorize! :create, :Menu
    data = params.require(:menu).permit(:date, :mealType, :firstCourse, :secondCourse, :sideDish, :notes, :canteen)
    if(data[:date].to_date() < Date.today.at_beginning_of_week && date[:date].to_date() > Date.today.at_beginning_of_week &&
      (data[:mealType] == "lunch" || data[:mealType] == "dinner"))
      flash[:warning] = 'Incorrect selected date'
    else 
      data[:canteen] = current_user
      unless Menu.where('date=? and mealType=?', data[:date], data[:mealType]).empty?
        flash[:warning] = 'Already existing Menu'
        redirect_to menus_path
        return
      end
      @menu = Menu.new(data)
      res = @menu.save
      if res
        flash[:notice] = 'Menu created'
      else
        flash[:warning] = 'Cannot create menu'
      end
      redirect_to new_menu_path
    end
  end

  def update
    authorize! :update, :Menu
    data = params.require(:menu).permit(:date, :mealType, :firstCourse, :secondCourse, :sideDish, :notes, :canteen)
    if(data[:date].to_date() < Date.today.at_beginning_of_week && date[:date].to_date() > Date.today.at_beginning_of_week &&
      (data[:mealType] == "lunch" || data[:mealType] == "dinner"))
      flash[:warning] = 'Incorrect selected date or meal'
    else
      @menu = Menu.find(params[:id])
      res = @menu.update(data)
      if res
        flash[:notice] = 'Menu updated'
      else
        flash[:warning] = 'Cannot update menu'
      end
      redirect_to menus_path
    end
  end

  def destroy
    authorize! :destroy, :Menu
    @menu = Menu.find(params[:id])
    @menu.destroy
    flash[:notice] = 'Menu deleted'
    redirect_to menus_path
  end
end