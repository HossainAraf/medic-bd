Rails.application.routes.draw do
    # API root welcome
  # root to: proc { [200, {}, ['{"message": "Welcome to the API"}']] }, via: :get
  # Lightweight health check
  # get '/health', to: ->(_) { [200, {}, ['OK']] }

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
          get 'filtered_doctors'
        end

        collection do
          get 'order/:order', to: 'doctors#filter_by_order' # Custome route for filtering doctors by order
        end
        
        #  get 'test_route', to: 'doctors#test_route'
      end
    end  
  end

  # Regular Rails routes for full-stack functionality
   # Root route
  root 'home#index'

  # Specializations > Districts > Doctors
  resources :specializations, only: [:index, :show] do
    resources :districts, only: [:index, :show] do
      resources :doctors, only: [:index, :show]
    end
  end  

  # Static pages

  # Health check route
  get '/health', to: ->(_) { [200, {}, ['OK']] }
end
