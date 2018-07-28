# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :read, :Reservation
  end

  def new
    authorize! :create, :Reservation
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.create
  end

  def newGuest
    authorize! :create, :Reservation
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.create
  end

  def edit
    authorize! :update, :Reservation
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.find(params[:id])
  end

  def show
    authorize! :read, :Reservation
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.find(params[:id])
  end

  def create
    authorize! :create, :Reservation
    @menu = Menu.find(params[:menu_id])
    data = params.require(:reservation).permit(:typeReservation, :firstCourseAlternatives, :secondCourseAlternatives, :sideDishAlternatives, :sideDish, :notes, :student, :menu)
    if params[:email].present?
      data[:student] = Student.all.where(email: params[:email]).take
    else
      data[:student] = current_user
    end
    if data[:typeReservation].include? "guest" 
      if params[:number].present?
        data[:typeReservation] = data[:typeReservation] + params[:number]
      end
    end
    if data[:typeReservation].include? "none"
      flash[:notice] = 'You have chosen not to make a reservation'
    else
      if params[:delete].present? 
        myDestroy(Reservation.all.where(student: data[:student], menu: @menu, typeReservation: data[:typeReservation]).take.id)
      else
        data[:menu] = @menu
        unless Reservation.where('typeReservation=? and student_id=? and menu_id=?', data[:typeReservation], data[:student], data[:menu]).empty?
          flash[:warning] = 'Already existing Reservation'
          if current_user.instance_of? Student
            redirect_to reservations_path
          end
          if current_user.instance_of? Canteen
            redirect_to new_menu_reservation_path(@menu.id)
          end
          return
        end
        @reservation = Reservation.new(data)
        res = @reservation.save
        if res
          flash[:notice] = 'Reservation created'
        else
          flash[:warning] = 'Cannot create reservation'
        end
      end
    end
      if current_user.instance_of? Student
        redirect_to reservations_path
      end
      if current_user.instance_of? Canteen
        redirect_to new_menu_reservation_path(@menu.id)
      end
  end

  def update
    authorize! :update, :Reservation
    data = params.require(:reservation).permit(:typeReservation, :firstCourseAlternatives, :secondCourseAlternatives, :sideDishAlternatives, :sideDish, :notes, :student, :menu)
    if data[:typeReservation] == "none"
      flash[:notice] = 'To cancel the reservation click on the delete link'
    else
      @reservation = Reservation.find(params[:id])
      res = @reservation.update(data)
      if res
        flash[:notice] = 'Reservation updated'
      else
        flash[:warning] = 'Cannot update reservation'
        flash[:warning] = @reservation
        flash[:warning] = res
      end
    end
    redirect_to menu_reservation_path
  end

  def destroy
    authorize! :destroy, :Reservation
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = 'Reserve deleted'
    redirect_to reservations_path
  end

  protected
  
  def myDestroy(reservation_id)
    @reservation = Reservation.find(reservation_id)
    @reservation.destroy
    flash[:notice] = 'Reserve deleted'
  end
end