class Users::SessionsController < Devise::SessionsController

  # require 'auth_token'

  #Disable CSRF protection
  skip_before_action :authenticate_user_from_token!, :only => :create

  respond_to :html, :json

  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   # set_flash_message(:notice, :signed_in) if is_flashing_format?
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?

  #   token = AuthToken.issue_token({user_id: resource.id})
  #   respond_with resource, location: after_sign_in_path_for(resource) do | format |
  #     format.json {render json: {user: resource.email, token: token} }
  #   end
  # end

  def create
    puts "WE MADE IT HERE!"

    @user = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless @user

    if @user.valid_password?(params[:password])
      sign_in :user, @user
      render json: @user, root: nil
    else
      invalid_login_attempt
    end
  end

  private

  def invalid_login_attempt
    warden.custom_failure!
    render json: {error: 'sessions_controller.invalid_login_attempt'}, status: :unprocessable_entity
  end
end
