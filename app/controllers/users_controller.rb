class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :json => @user
    else
      render :json => {response: 'You done fucked up'}
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :json => @user
    else
      render :json => {response: 'Failed to save User'}
    end
  end

  def update
    if @user.update(user_params)
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
    params.require(:user).permit(:username, :email, :password)
  end
end
