class Web::BaseController < ApplicationController
  # CSRF protection
  protect_from_forgery with: :exception
end
