class Api::V1::DistrictsController < ApplicationController
  def index
    districts = District.all
    render json: districts, only: %i[id name]
  end
end
