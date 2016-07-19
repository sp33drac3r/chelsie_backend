class ApiController < ApplicationController
  before_filter :verify_jwt_token

  def test
    respond_to do |format|
      format.json {render json: {'sample' => 'data'}}
    end
  end
end
