BCalIntegration::Application.routes.draw do
  resources :events
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  match '/sign_up',  to: 'users#new',            via: 'get', :as => :sign_up
  match '/sign_in',  to: 'sessions#new',         via: 'get'
  match '/sign_out', to: 'sessions#destroy',     via: 'delete'

  resources :calendars

  get "calendar/auth/:id", :to => "calendars#auth"
  get "oauth_redirect", :to => "calendars#oauth_redirect", :as => :oauth

  resources :requests, :except => [:destroy]

  root :to => 'calendars#index'

  match 'about' => 'calendars#index'

end
