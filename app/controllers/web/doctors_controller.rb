# app/controllers/web/doctors_controller.rb

class Web::DoctorsController < Web::BaseController
  def index
    @specializations = Specialization.all

    select_specialization = Specialization.find_by(id: params[:specialization_id])

    @districs = Doctor.all.distinct.pluck(:district)

    @doctors = Doctor.all
    @doctors = @doctors.where(specialization_id: @select_specialization.id) if select_specialization
    @doctors = @doctors.where(district: params[:district_id]) if params[:district_id].present?
  end
end