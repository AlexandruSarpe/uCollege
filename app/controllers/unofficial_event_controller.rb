class UnofficialEventController < ApplicationController
    before_action :authenticate_user! #si deve autenticare
    skip_before_action :authenticate_user! ,only: [:index, :show] #ma non sempre(visualizzare tutti)
    
    def index
        authorize! :read, :Unofficial_Event
        @events = UnofficialEvent.all.order('date DESC')
    end

    def new
        authorize! :create, :Unofficial_Event
        @events =UnofficialEvent.new
    end

    def create
        authorize! :create, :Unofficial_Event
        values = event_params
            
        @events = UnofficialEvent.new(values)
        @events.creator=current_user

        if @events.save
            flash[:notice]="success"
            redirect_to  unofficial_event_index_path
        else
            render 'new'
        end

    end


    def show
        @event = UnofficialEvent.find(params[:id])
    end

    def destroy
        @event = UnofficialEvent.find(params[:id])
        @event.destroy
        flash[:notice] = 'Unofficial Event deleted'
        redirect_to unofficial_event_path
    end


    def edit
        @event = UnofficialEvent.find(params[:id])
      end

    def update
        @event = UnofficialEvent.find(params[:id])
        data = params.require(:event).permit(:name, :place, :date, :notes)
        res = @event.update(data)
        if res
          flash[:notice] = 'Event updated'
        else
          flash[:warning] = "Can't update Event"
        end
        redirect_to unofficial_event_path(@event)
    end

    private
    def event_params
        params.require(:unofficial_event).permit(:name,:place,:notes)
    end

    def find_event
        @events = UnofficialEvent.find(params[:id])
    end
end

