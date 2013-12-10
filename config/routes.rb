BCalIntegration::Application.routes.draw do
  # resources :events
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :calendars do
    resources :blocked_times
  end
  resources :requests

  root :to => 'calendars#index'
  match 'sign_in',  to: 'sessions#new',         via: 'get'
  match 'sign_out', to: 'sessions#destroy'

  get "calendar/:id/auth", :to => "calendars#auth", :as => :oauth
  get "oauth_redirect", :to => "calendars#oauth_redirect"
  get 'about', :to => "static#about"
end
