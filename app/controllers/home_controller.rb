class HomeController < ApplicationController
    def index
        render plain: "Welcome to the Home Page!"
    end
end
