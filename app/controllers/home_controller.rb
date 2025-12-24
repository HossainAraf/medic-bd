class HomeController < Web::BaseController
  # protect_from_forgery with: :exception
  # layout 'application'

  def index
    # Optional: Set a test flash message
    # flash[:notice] = "Welcome to MedicBD!" if flash.empty?
  end
end
