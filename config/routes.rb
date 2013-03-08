Bedpres::Application.routes.draw do

  root :to => "presentations#index"

  resources :users do
    collection do
      get 'forgot_password' => 'users#forgot_password'
      post 'forgot_password' => 'users#generate_forgot_password_email'
    end

    member do
      get 'reset_password/:hash' => 'users#reset_password', :as => :reset_password
      post 'reset_password/:hash' => 'users#change_password', :as => :reset_password

      get 'verify_account/:hash' => 'users#verify_account', :as => :verify_account
    end
  end

  resources :presentations do
    resources :participations, :only => [:create, :destroy]

    member do
      post 'toggle_cancel'
    end
  end

  resources :notifications

  match '/login', :to => 'sessions#new', :via => :get
  match '/login', :to => 'sessions#create', :via => :post
  match '/logout', :to => 'sessions#destroy', :via => :post

  match '/registrate_card' => redirect('https://medlem.samfundet.no/account/regcard'), :as => :registrate_card
  match '/forgot_card_password' => redirect('https://medlem.samfundet.no/account/lostpwd'), :as => :forgot_card_password

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

ActionDispatch::Routing::Translator.translate_from_file 'config/locales/routes.yml'
