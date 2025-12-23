module Api
    class BaseController < ApplicationController::API
        protect_from_forgery with: :null_session
    end
end