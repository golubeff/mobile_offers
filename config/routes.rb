MobileOffers::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  match "/offers", to: "offers#index", via: :get
  resources :users
end