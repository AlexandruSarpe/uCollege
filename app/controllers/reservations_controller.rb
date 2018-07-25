class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :read, :Reservation
  end

  def new
    authorize! :create, :Reservation
  end

end
