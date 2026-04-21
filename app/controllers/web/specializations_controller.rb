class Web::SpecializationsController < Web::BaseController
  # skip_before_action :authorize_request
  def index
    @specializations = Specialization.all
  end
end
