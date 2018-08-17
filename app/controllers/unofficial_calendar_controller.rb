class UnofficialCalendarController < ApplicationController
    before_action :authenticate_user! #si deve autenticare
    skip_before_action :authenticate_user! ,only: [:index, :show] #ma non sempre(visualizzare tutti)
    
    def index
        @events = UnofficialEvent.all
    end

end
