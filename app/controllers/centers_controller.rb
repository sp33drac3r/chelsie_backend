class CentersController < ApplicationController
  def index
    @centers = Center.all
    render :json => @centers
  end

  def show
    @center = Center.find(params[:id])
    render :json => @center
  end

  def services
  end

  def populations
  end

  def query
  end

  def location

  end

  def state
  end
end
