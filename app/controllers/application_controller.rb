# class ApplicationController < ActionController::Base
#   require 'auth_token'

#   # protect_from_forgery with: :exception

#   protected

#   def verify_jwt_token
#     head :unauthorized if request.headers['Authorization'].nil? ||
#     !AuthToken.valid?(request.headers['Authorization'].split(' ').last)
#   end
# end

class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  # def index
  #   @centers = ServiceProvider.all
  #   render :json => @centers
  # end

  before_action :authenticate_user_from_token!
  # protect_from_forgery with: :null_session

  respond_to :json

  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']

    if auth_token
      authenticate_with_auth_token auth_token
    else
      authentication_error
    end
  end

  private

  def authenticate_with_auth_token auth_token
    unless auth_token.include?(':')
      authentication_error
      return
    end

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.access_token, auth_token)
      # User can access
      sign_in user, store: false
    else
      authentication_error
    end
  end

  ##
  # Authentication Failure
  # Renders a 401 error
  def authentication_error
    # User's token is either invalid or not in the right format
    render json: {error: 'unauthorized'}, status: 401  # Authentication timeout
  end

end
