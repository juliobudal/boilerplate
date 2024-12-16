Rails.application.routes.draw do
  # Authentication routes
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  }

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  root 'home#index'

  resources :study_areas do
    resources :goals do
      member do
        patch :update_status
      end
    end
  end

  resources :goals do
    resources :resources, shallow: true
    resources :study_sessions, only: [:create, :index]
    member do
      patch :update_progress
    end
  end

  # Place this before the standalone resources route to avoid conflict
  get 'resources', to: 'resources#all', as: :resources
  # resources :resources, except: [:index]

  resources :tags

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resource :profile, only: [:edit, :update]
end
