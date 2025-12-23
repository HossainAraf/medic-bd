module Web
    class BaseController < ApplicationController
        # Inherits CSRF protection from ApplicationController
        layout "application"
    end
end