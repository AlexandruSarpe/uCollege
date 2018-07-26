class MenusController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :read, :Menu
  end

  def new
    authorize! :create, :Menu
    @menu=Menu.create
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
      redirect_to "/menus/new"
    end
  end
end