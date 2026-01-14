Rails.application.routes.draw do
  # API root welcome
  root to: proc { [200, {}, ['{"message": "Welcome to the API"}']] }, via: :get

  # Lightweight health check
  get '/health', to: ->(_) { [200, {}, ['OK']] }

  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'sessions#create'

      resources :medic_users, except: %i[new edit]
      resources :chambers, only: [:index]
      resources :districts

      resources :specializations, only: %i[index show create] do
        get 'doctors', on: :member
      end

      resources :doctors, param: :slug, only: %i[index show create update destroy] do
        collection do
          get :by_specialization_query
          get 'display_order/:display_order', action: 'filter_by_display_order'
        end

        # Nested schedules (collection-level)
        resources :doctor_schedules, only: %i[index create]
      end

      # Schedule member-level actions
      resources :doctor_schedules, only: %i[show update destroy]
    end
  end
end
