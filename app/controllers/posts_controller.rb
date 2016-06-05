class PostsController < ApplicationController
  def index
    @school = Center.all
    render :json => @centers
  end

  def show
    @center = Center.find(params[:id])
    render :json => @center
  end
end
