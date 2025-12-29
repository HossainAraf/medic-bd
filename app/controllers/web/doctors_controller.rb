# app/controllers/web/doctors_controller.rb

class Web::DoctorsController < Web::BaseController
  def index
    @specializations = Specialization.order(:name)
    @districts = District.order(:name)

    @doctors = Doctor
      .includes(
        :specializations,
        doctor_schedules: { chamber: :district }
      )
      .distinct

    if params[:specialization_id].present?
      @doctors = @doctors.joins(:doctor_specializations)
                        .where(doctor_specializations: {
                          specialization_id: params[:specialization_id]
                        })
    end

    if params[:district_id].present?
      @doctors = @doctors.joins(doctor_schedules: { chamber: :district })
                        .where(districts: { id: params[:district_id] })
    end
  end

  end