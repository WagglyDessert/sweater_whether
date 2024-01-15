Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      resources :user_third_spaces, only: [:create]
      get "/forecast", to: "forecast#location"
    end
  end
end
