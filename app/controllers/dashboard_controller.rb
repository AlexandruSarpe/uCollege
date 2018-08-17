# frozen_string_literal: true

# noinspection RailsParamDefResolve
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index;
  end
  
end
