Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Authentication routes
  get "login", to: "auth#login", as: :login
  post "auth/create", to: "auth#create", as: :auth_create
  
  # Session routes
  get "sessions/callback", to: "sessions#callback", as: :sessions_callback
  delete "logout", to: "sessions#destroy", as: :logout
  get "logout", to: "sessions#destroy"

  # Public pet tags
  get "tags/:uuid", to: "tags#show", as: :tags_show
  get "tags/:uuid/qr", to: "tags#qr", as: :tags_qr

  # Pet routes
  resources :pets do
    resources :pet_infos, except: [:show]
    get 'pet_infos/:id/delete', to: 'pet_infos#destroy', as: :delete_pet_info
  end

  # Defines the root path route ("/")
  root "home#index"
end
