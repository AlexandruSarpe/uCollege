# frozen_string_literal: true

# avoid that a user can login as another user while logged
module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_user
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(authenticated_root_path)
    end
  end
end
