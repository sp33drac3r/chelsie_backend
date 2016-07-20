require 'json'
class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # skip_before_filter :verify_authenticity_token, :only => :create

  skip_before_action :authenticate_user_from_token!, only: [:create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    puts "W ARE IN USERS CONTROLLER"

    # if user_params['is_host']
    #   @user = User.new user_params
    # else
    #   host = User.find_by(host_code: user_params['host_code'])

    #   @user = User.new user_params
    #   @user['host'] = host.id
    #   host.guest = @user.id
    #   host.save
    # end
     params = JSON.parse(request.body.read)["user"]
     # params = JSON.parse(params)
     p params

     @user = User.new(email: params["email"], password: params["password"], password_confirmation: params["password_confirmation"])
     # p user_params

    if @user.save
      render json: @user, root: nil
    else
      render json: { error: 'user_create_error' }, status: :unprocessable_entity
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
