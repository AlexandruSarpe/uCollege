# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  skip_before_action :require_no_authentication, only: %i[new create]

  # GET /resource/sign_up
  def new
    super
  end

  def show
    @user = User.find(params[:id])
    authorize! :read, @user.type.to_sym
  end

  # POST /resource
  def create
    # only secretary user can create other types of users
    sign_up_params[:type] = 'Student' unless user_signed_in? && current_user.type == 'Secretary'
    build_resource(sign_up_params)
    authorize! :create, sign_up_params[:type].to_sym,
               message: "You can't create a new #{sign_up_params[:type]}!"
    resource.save
    # if we are a secretary user creating a user we can't login with the newly created user
    if user_signed_in?
      flash[:notice] = "Successfully created a new #{sign_up_params[:type]}"
      redirect_to authenticated_root_path
      return
    end
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    authorize! :update, resource.type.to_sym, message: "You can\'t modify this user info!"
    super
  end

  # DELETE /resource
  def destroy
    authorize! :destroy, resource.type.to_sym, message: "You can\'t delete this user!"
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name username type])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name username])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
