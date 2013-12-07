BCalIntegration::Application.routes.draw do
  resources :events
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  match '/sign_up',  to: 'users#new',            via: 'get', :as => :sign_up
  match '/sign_in',  to: 'sessions#new',         via: 'get'
  match '/sign_out', to: 'sessions#destroy',     via: 'delete'

  resources :calendars

  get "calendar/:id/auth", :to => "calendars#auth", :as => :oauth
  get "oauth_redirect", :to => "calendars#oauth_redirect"

  resources :requests, :except => [:destroy]

  root :to => 'calendars#index'

  get 'about', :to => "static#about"

end
