Rails.application.routes.draw do
  # --------------------
  # API ROUTES (JSON)
  # --------------------
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'sessions#create'

      resources :medic_users, except: [:new, :edit]
      resources :chambers, only: [:index]
      resources :districts
      resources :specializations, only: [:index, :show, :create] do
        get 'doctors', to: 'specializations#doctors'
      end

      resources :doctors, only: [:index, :show, :create, :destroy, :update] do
        collection do
          get 'filtered_doctors'
          get 'order/:order', to: 'doctors#filter_by_order'
        end
      end
    end
  end

  # --------------------
  # WEB ROUTES (HTML)
  # --------------------
  namespace :web do
    root 'home#index'

    get 'ambulance', to: 'ambulance#index'
    get 'bloodbank', to: 'bloodbank#index'
    get 'clinics-and-hospitals', to: 'clinics_and_hospitals#index'
    get 'diagnostics', to: 'diagnostics#index'

    get  'feedback', to: 'feedbacks#index'
    post 'feedback', to: 'feedbacks#create'

    # static pages
    get 'about_us', to: 'static_pages#about'
    get 'contact_us', to: 'static_pages#contact_us'
    get 'disclaimer', to: 'static_pages#disclaimer'

    # Specializations → Districts → Doctors
    resources :doctors, only: [:index]
  end

  # --------------------
  # HEALTH CHECK
  # --------------------
  get '/health', to: ->(_) { [200, {}, ['OK']] }
end
