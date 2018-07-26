class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :read, :Reservation
  end

  def new
    authorize! :create, :Reservation
  end

  def newGuest
    authorize! :create, :Reservation
  end

  def edit
    authorize! :update, :Reservation
  end

  def show
    authorize! :read, :Reservation
  end

end
