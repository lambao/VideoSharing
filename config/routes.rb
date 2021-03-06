VideoSharing::Application.routes.draw do
  resources :videos
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'home_pages#home'
  match 'post_video', to: 'videos#new', via: [:get, :post]
  match 'my_video', to: 'videos', via: [:get]
  match 'increase_count', to: 'videos#increase_count_view', via: [:put]
  match 'lastest', to: 'home_pages#lastest', via: [:get]
  match 'hot', to:'home_pages#hot', via: [:get]
  match 'user_list', to: 'manage_users#index', via: [:get]
  get 'manage_user/edit/:id', to: 'manage_users#edit'
  post 'manage_user/edit/:id', to: 'manage_users#update'
  match 'user_token', to:'manage_users#generate_token', via: [:get, :post]
  match 'generate', to: 'manage_users#generate', via: [:post]
  match 'show/:id', to: 'videos#show', via: [:get]

  namespace :api do
    namespace :v1 do
      resources :tokens, :only => [:create, :destroy, :generate]
      resources :videos
      match 'hot', to: 'videos#hot_videos', via: [:get]
      match 'lastest', to: 'videos#lastest_videos', via: [:get]
      match 'show/:id', to: 'videos#show', via: [:get]
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
