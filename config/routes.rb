Rails.application.routes.draw do
    # API root welcome
  root to: proc { [200, {}, ['{"message": "Welcome to the API"}']] }, via: :get
  # Lightweight health check
  get '/health', to: ->(_) { [200, {}, ['OK']] }

  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'sessions#create'
      resources :medic_users, except: [:new, :edit]
      resources :chambers, only: [:index]
      resources :districts
      resources :specializations, only: [:index, :show, :create] do
        # Custom route for fetching doctors by specialization
        get 'doctors', to: 'specializations#doctors'
      end
      resources :doctors, only: [:index, :show, :create, :destroy, :update]  do
      # Custom route for filtering doctors by district and specialization
        collection do
          get 'by_specialization_query'
        end

        collection do
          get 'display_order/:display_order', to: 'doctors#filter_by_display_order' # Custome route for filtering doctors by display_order
        end
        # Doctor Schedules
        resources :doctors, only: [] do
          resources :doctor_schedules, only: [:index, :create]
        end
        resources :doctor_schedules, only: [:show, :update, :destroy]
      end
    end  
  end
end
