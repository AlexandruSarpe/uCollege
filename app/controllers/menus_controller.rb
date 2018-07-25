class MenusController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :view, :Menu
    @menuLunch = findLunch(Time.now.strftime("%d/%m/%Y"))
    @menuDinner = findDinner(Time.now.strftime("%d/%m/%Y"))
  end

  def new
    authorize! :create, :Menu
  end

  protected

  def findLunch(paramDate)
    @menu = Menu.where("date=#{paramDate}, mealType='lunch'")
  end

  def findDinner(paramDate)
    @menu = Menu.where("date=#{paramDate}, mealType='dinner'")
  end
end