class ErrorsController < ActionController::Base
  protect_from_forgery with: :null_session

  def not_found
    flash[:warning]='not found'
    redirect_to root_path
  end

  def internal_server_error
    flash[:warning]='internal server error'
    redirect_to root_path
  end
end