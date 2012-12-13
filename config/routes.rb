Bees::Application.routes.draw do

  
  

  get "comments/create"

  get "account", to: "account#index"
  get "account/subscription", to: "account#subscription"
  get "account/order", to: "account#order"

  resources :subscriptions
  post "subscriptions/new"
  get "confirm_subscription", to: "gocardless#confirm_subscription"
  get 'cancel_subscription', to: 'subscriptions#cancel_subscription'
  get 'confirm_cancel_subscription', to: 'gocardless#confirm_cancel_subscription'

  get "join", to: 'join#index' 

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  
  resources :sessions
  resources :users
  
  # Blog
  match 'articles/category', to: 'articles#category'
  match 'articles/all', to: 'articles#all'
	match 'articles/:permalink', to: 'articles#show'
	get 'blog', to: 'articles#index'
	resources :article_categories
	resources :articles
	resources :comments
  
  # Static Pages
  get 'craft_boxes', to: 'pages#craft_boxes'
  get 'about_us', to: 'pages#about_us'
	get 'terms', to: 'pages#terms'
	get 'faq', to: 'pages#faq'
  get 'privacy', to: 'pages#privacy'
  get 'contact', to: 'pages#contact'
  get 'newsletter', to: 'pages#newsletter'
  get 'reset_password', to: 'sessions#reset_password'
  get 'change_password', to: 'account#change_password'
  post 'send_contact_form', to: 'pages#send_contact_form'
  post 'newsletter_signup', to: 'pages#newsletter_signup'
  post 'send_new_password', to: 'sessions#send_new_password'
  post 'send_change_password', to: 'account#send_change_password'


  # Shop pages
  resources :shop_cart_items
  
  get 'shop', to: 'shop#index'
  match 'shop/category', to: 'shop#category'
  get 'shop/product_details'
  get 'shop/basket'
  get 'shop/checkout'
  post 'shop/create_order'
  get 'shop/empty_basket'
  post 'shop_cart_items/update_items'
  get 'confirm_shop_order', to: 'gocardless#confirm_shop_order'

  # Manager Static Pages
  get 'manager', to: 'manager#index'
  get 'manager/subscription_details', to: 'manager#subscription_details'
  get 'manager/pack_sheets', to: 'manager#pack_sheets'

  get 'manager/month_end', to: 'manager#month_end'
  post 'manager/process_month_end', to: 'manager#process_month_end'
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

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
  root :to => 'pages#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
