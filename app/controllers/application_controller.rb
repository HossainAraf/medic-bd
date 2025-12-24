class ApplicationController < ActionController::Base
  # CSRF Protection
  protect_from_forgery with: :exception
end
