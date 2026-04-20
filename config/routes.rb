Rails.application.routes.draw do
  get '/health', to: ->(_) { [200, {}, ['OK']] }

  # API routes
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'sessions#create'

      resources :medic_users, only: %i[index create]
      resources :chambers, only: %i[index show create update destroy]
      resources :districts

      resources :specializations, only: %i[index show create] do
        get 'doctors', on: :member
      end

      resources :doctors, param: :slug do
        collection do
          get :by_specialization_query
          get 'display_order/:display_order', action: 'filter_by_display_order'
        end

        # Nested schedules 
        resources :doctor_schedules, only: %i[index create] do
          collection do
            patch :bulk_update
          end
        end
      end
    end
  end

  # Web routes
  scope module: :web do
    resources :specializations, only: %i[index]
  end
end
