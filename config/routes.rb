Depot::Application.routes.draw do

  resources :history_items

  resources :comments

  resources :book_types

  resources :shops

  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :products

  get "store/index"

  post "store/ajax_show_products"

  resources :products do
    get :who_bought, :on => :member
  end

  root :to => 'store#index', :as => 'store'
  controller :store do
    get 'show_products' => :show_products
  end

  match 'shops/:id/show_to_buyers', :to => 'shops#show_to_buyers'
  match 'news/:id/show_to_buyers', :to => 'news#show_to_buyers'
  match 'shops/:id/change_state', :to => 'shops#change_state'
  
  controller :products do
    get 'show_to_buyers' => :show_to_buyers
    get 'rate_to_product' => :rate_to_product
    post 'add_comment' => :add_comment
    post 'destroy_comment' => :destroy_comment
  end
  
  controller :news do
    get 'show_to_buyers' => :show_to_buyers
  end

  resources :users
  controller :users do
    get 'register' => :register
    post 'create_buyer' => :create_buyer
    get 'collections' => :collections
    post 'add_collection' => :add_collection
    post 'cancel_collection' => :cancel_collection
  end
  
  resources :orders

  resources :line_items

  resources :carts
  
  resources :news
  
  resources :advertisements
  
  controller :error do
    get 'error/building' => :building
    get 'error/error_info' => :error_info
  end

#match 'products/:id/show_to_buyers', :to => 'products#show_to_buyers'

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
# root :to => "welcome#index"

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
# match ':controller(/:action(/:id(.:format)))'
end
