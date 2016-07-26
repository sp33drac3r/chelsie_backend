class UsersController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :only => :create
  # skip_before_filter :verify_authenticity_token, :only => :create

  # def index
  #   render :json => {response: 'You are not alone.'}
  # end

   # before_filter :verity_jwt_token

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    unless @posts.empty?
      render :json => {
          :email => @user.email,
          :posts => @posts,
        }
    else
      render :json => {
        email: @user.email,
        response: 'No posts for this user'
      }
    end
  end

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

    if @user.save
      render json: @user, serializer: SessionSerializer, root: nil
    else
      render json: { error: t('user_create_error') }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      @user.email = nil
      @user.password = nil
      render :json => @user
    else
      render :json => {response: 'Failed to update'}
    end
  end

  def destroy
    @user = User.find_by(params[:id])
    if @user.destroy
      render :json => {response: 'User deleted'}
    else
      render :json => {response: 'Failed to delete User'}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
