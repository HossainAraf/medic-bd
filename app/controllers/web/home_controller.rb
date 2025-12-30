# app/controllers/web/home_controller.rb
class Web::HomeController < Web::BaseController
  def index
    @specializations = Specialization.order(:name)
    @districts = District.order(:name)

    # return unless params[:specialization_id].present?

    # @doctors = Doctors::FilterQuery.new(
    #   specialization_id: params[:specialization_id],
    #   district_id: params[:district_id]
    # ).call
  end
end
