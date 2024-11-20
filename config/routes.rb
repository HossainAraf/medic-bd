Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :doctors, only: [:index, :show, :create, :destroy, :update]  do
      # Custom route for filtering doctors by district and specialization
        collection do
          get 'filtered_doctors'
        end
      end
    end  
  end
      # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "home#index"
  root to: proc { [200, {}, ['{"message": "Welcome to the API"}']] }, via: :get

end
