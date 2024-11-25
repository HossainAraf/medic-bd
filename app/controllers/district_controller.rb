class DistrictController < ApplicationController
  def index
    @districts = District.all
    render json: @districts
  end
end
