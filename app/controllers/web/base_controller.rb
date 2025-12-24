module Web
  class BaseController < ApplicationController
    protect_from_forgery with: :exception
    # layout "application"
  end
end
