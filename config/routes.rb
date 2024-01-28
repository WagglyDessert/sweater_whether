Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      get "/forecast", to: "forecast#location"
      post "/users", to: "users#create"
      post "/sessions", to: "users#login"
      post "/road_trip", to: "roadtrip#duration"
    end
  end

  namespace :api do
    namespace :v1 do
      get "/munchies", to: "munchies#search"
    end
  end
end
