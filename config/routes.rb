Rails.application.routes.draw do
  #namespace :admin do
   # get 'users/index'
  #end
   namespace :admin do
    resources :users, only: [:index, :destroy] do
      member do
        patch :toggle_status
      end
    end
  end
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
  }

  get '/unauthorized', to: 'errors#unauthorized', as: :unauthorized
  #devise_for :users
  #get 'dashboad/index'
  resources :transferencias
  resources :contas
  resources :recebiveis do
    collection do
      post :create_bulk
    end
  end
  resources :pagamentos
  resources :pessoas
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "dashboad#index"
end
