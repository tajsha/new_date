require 'sidekiq/web'

Dating::Application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get 'edit' => 'users#edit'
  get "/profile/:id" => "users#show"
  get "profile/:id/settings" => 'users#edit'
  get 'settings/:id' => 'users#settings'
  get 'admin/users' => 'admin#users'
  get 'admin/subscriptions' => 'admin#subscriptions'
  get 'admin/letsgo' => 'admin#letsgo'
  get 'admin/messages' => 'admin#messages'
  get 'admin/qanda' => 'admin#qanda'
  get 'admin/pictures' => 'admin#pictures'
  get 'letsgos/eatdrink' => 'letsgos#eatdrink'
  get 'letsgos/listenwatch' => 'letsgos#listenwatch'
  get 'letsgos/play' => 'letsgos#play'
  get 'letsgos/other' => 'letsgos#other'
  get 'letsgos/explore' => 'letsgos#explore'
  get "subscriptions/cancelsubscription"
  get "subscriptions/updatesubscription"
  get "subscriptions/changecard"
  get "subscriptions/suspend"
  get "subscriptions/updatebilling"
  get "subscriptions/reactivate"
  get ":id/updatebilling" => "users#update_stripe_billing"
  match '/edit_card',   to: 'subscriptions#edit_card',   via: 'get'
  match '/update_card', to: 'subscriptions#update_card', via: 'post'
  get '/relationships/set_follow' => 'relationships#set_follow'
  get '/speed_dates' => 'users#speed_date'
  
  post 'subscription_event' => "webhooks#subscription_event"
  

    
    resources :messages do
      member do
      post :askout
      end
    end

      
  match '/paypal/ipn' => 'notifications#create', :via => [:get, :post], :as => 'notifications_create'
  
  resources :admin
  resources :charges
  resources :subscriptions
  resources :plans
  get 'paypal/checkout', to: 'subscriptions#paypal_checkout'
 
  resources :sessions
  resources :contacts, only: [:new, :create]
  resources :password_resets
  resources :galleries
  resources :photos do
    member do
      post :avatar
    end
  end
  resources :searches
  resources :sessions,      only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :letsgos, only: [:create, :destroy]
  resources :users do  
    get 'settings', on: :member  
    post 'follow', on: :member 
    post 'unfollow', on: :member
    get "follow", on: :member 
    get 'follow_popup', on: :member
    post :search, on: :collection
  end
  
  resources :letsgos do
    member do
      post :repost
      post :interested
    end
  end
  
  resources :questions do
    resources :answers, only: [:new, :create]
  end

          
  root to: 'users#index'
  
  resources :users do
  end
 
 resources :conversations do
     post :reply, on: :member
     post :trash_all, on: :collection
     post :untrash, on: :collection
   end

  resources :payments, only: [:show, :create, :destroy] do
     collection do
       get :success
       get :cancel
       post :notify
     end     
   end
   
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
