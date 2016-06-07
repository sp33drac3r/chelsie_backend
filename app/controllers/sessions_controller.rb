class SessionsController < ApplicationController
  def create
    p params[:email]
    @user = User.find_by_email(params[:email])
    p @user
    if @user && @user.authenticate(params[:password])
      render :json => @user
    else
      render :json => {response: 'User authentication failed'}
    end
  end
end
