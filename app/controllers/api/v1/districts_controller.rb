class Api::V1::DistrictsController < ApplicationController
  skip_before_action :authorize_request, only: [:index]

  def index
    districts = District.all
    render json: districts, only: %i[id name]
  end
end
