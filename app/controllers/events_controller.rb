# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user! # si deve autenticare
  skip_before_action :authenticate_user!, only: %i[index show] # ma non sempre(visualizzare tutti)

  def index
    authorize! :read, :Unofficial_Event
    authorize! :read, :Official_Event
    @events = Event.all.order('date DESC')
  end

  def new
    if current_user.instance_of? Student
      authorize! :create, :Unofficial_Event
      @event = UnofficialEvent.new
    elsif current_user.instance_of? Secretary
      authorize! :create, :Official_Event
      @event = OfficialEvent.new
    end
  end

  def create
    if current_user.instance_of? Student
      authorize! :create, :Unofficial_Event
      values = params.require(:unofficial_event).permit(:name, :place, :notes, :date)
      @event = UnofficialEvent.new(values)
    elsif current_user.instance_of? Secretary
      authorize! :create, :Official_Event
      values = params.require(:official_event).permit(:name, :place, :notes,:date)
      @event = OfficialEvent.new(values)
    else
      redirect_to events_path
    end
    @event.creator = current_user

    if @event.save
      flash[:notice] = 'success'
      redirect_to events_path
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    authorize! :read, :Unofficial_Event if @event.instance_of? UnofficialEvent
    authorize! :read, :Official_Event if @event.instance_of? OfficialEvent
  end

  def destroy
    @event = Event.find(params[:id])
    authorize! :destroy, :Unofficial_Event unless @event.instance_of? OfficialEvent
    authorize! :destroy, :Official_Event unless @event.instance_of? UnofficialEvent
    if current_user.instance_of? Student
      if @event.creator==current_user
        @event.destroy
        flash[:notice] = 'Unofficial Event deleted'
      else
        flash[:warning]= 'only the event creator can delete it'
        redirect_to events_path
      end
    elsif current_user.instance_of? Secretary
      @event.destroy
      flash[:notice] = 'Unofficial Event deleted'
    else
      flash[:warning]= 'not enough permissions'
      redirect_to events_path
    end
    redirect_to events_path
  end


  def edit
    @event = Event.find(params[:id])
    authorize! :update, :Unofficial_Event if @event.instance_of? UnofficialEvent
    authorize! :update, :Official_Event if @event.instance_of? OfficialEvent
    if @event.instance_of?(UnofficialEvent) && current_user!= @event.creator
      flash[:warning]= 'only the event creator can update it'
      redirect_to events_path
    end
  end

  def update
    @event = Event.find(params[:id])
    authorize! :update, :Unofficial_Event if @event.instance_of? UnofficialEvent
    authorize! :update, :Official_Event if @event.instance_of? OfficialEvent
    if @event.instance_of?(UnofficialEvent) && current_user!= @event.creator
      flash[:warning]= 'only the event creator can update it'
      redirect_to events_path
    end
    data = params.require(:unofficial_event).permit(:name, :place, :notes, :date)  if @event.instance_of? UnofficialEvent
    data = params.require(:official_event).permit(:name, :place, :notes,:date)  if @event.instance_of? OfficialEvent
    res = @event.update(data)
    if res
      flash[:notice] = 'Event updated'
    else
      flash[:warning] = "Can't update Event"
    end
    redirect_to event_path(@event)
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :notes,:date)
  end

end
