module Api
    class BaseController < ApplicationController::Api
        protect_from_forgery with: :null_session
    end
end