class Api::V1::ChambersController < ApplicationController
  def index
    if params[:district_id].present?
      @chambers = Chamber.where(district_id: params[:district_id]).includes(:district)
    else
      @chambers = Chamber.all.includes(:district)
    end

    render json: @chambers.as_json(include: { district: { only: [:name] } })
    end
  end
end
