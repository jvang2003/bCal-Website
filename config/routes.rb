BCalIntegration::Application.routes.draw do
  resources :events
  resources :user
  resources :sessions, only: [:new, :create, :destroy]
  match '/sign_up',  to: 'users#new',            via: 'get', :as => "sign_up"
  match '/sign_in',  to: 'sessions#new',         via: 'get'
  match '/sign_out', to: 'sessions#destroy',     via: 'delete'


  get "calendar/create", :to => "calendar#new", :as => "new_cal"
  post "calendar/create", :to => "calendar#create", :as => "create_cal"
  put "calendar/update/:id", :to => "calendar#update", :as => "update_cal"
  get "calendar/edit/:id", :to => "calendar#edit", :as => "edit_cal"
  get "calendar/show/:id", :to => "calendar#show", :as => "show_cal"
  delete "calendar/edit/:id" => "calendar#destroy"

  get "calendar/auth/:id", :to => "calendar#auth"

  # get "/request/show", :to => "request#show", :as => "show_requests"
  # get "/request/create", :to => "request#new", :as => "new_request"
  # get "/request/edit", :to => "request#edit", :as => "edit_requests"

  root :to => 'calendar#index', :as => "calendars"
  resources :request

  match 'about' => 'calendar#index'

  get "oauth_redirect", :to => "calendar#oauth_redirect", :as => :oauth

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"
end
