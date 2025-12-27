Rails.application.routes.draw do
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
   scope module: 'web' do
  root 'home#index'
  get 'ambulance', to: 'ambulance#index', as: 'ambulance'
  get 'bloodbank', to: 'bloodbank#index', as: 'bloodbank'
  get 'clinics-and-hospitals', to: 'clinics_and_hospitals#index', as: 'clinics_and_hospitals'
  get 'diagnostics', to: 'diagnostics#index', as: 'diagnostics'
  get 'feedback', to: 'feedbacks#index', as: 'feedback'
  post 'feedback', to: 'feedbacks#create', as: 'create_feedback'
  #static pages
  get 'about_us', to: 'static_pages#about', as: 'about_us'
  get 'contact_us', to: 'static_pages#contact_us', as: 'contact_us'
  get 'disclaimer', to: 'static_pages#disclaimer', as: 'disclaimer'



  # Specializations > Districts > Doctors
  resources :specializations, only: [:index, :show] do
    resources :districts, only: [:index, :show] do
      resources :doctors, only: [:index, :show]
    end
  end 
  resources :doctors, only: [:index, :show]
  resources :districts, only: [:index, :show]
  resources :chambers, only: [:index, :show]
  resources :medic_users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :appointments, only: [:new, :create, :index, :show, :destroy]

  # Static pages

  # Health check route
  get '/health', to: ->(_) { [200, {}, ['OK']] }
  
resources :turbo_test, only: [:index, :create]
  end
end
