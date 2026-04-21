class Web::BaseController < ApplicationController
  layout "web"

  # CSRF protection
  protect_from_forgery with: :exception
end
