CodechefClone::Application.routes.draw do
  root :to => "challenges#easy"

  get 'static_pages/about'
  get 'static_pages/categories'

  get 'challenges/easy'
  get 'challenges/medium'
  get 'challenges/hard'

  get 'users/easy'
  get 'users/medium'
  get 'users/hard'
  get 'users/points'

  get 'follows/easy'
  get 'follows/medium'
  get 'follows/hard'
  get 'follows/points'

  resources :users, :only => [:create, :new, :show, :edit, :update, :index]
  resource :session, :only => [:create, :destroy, :new]
  resources :challenges, :only => [:create, :new, :show]
  resources :input_results, :only => [:create, :new]
  resources :allowed_methods, :only => [:create, :new]
  resources :solutions, :only => [:create]
  resources :follows, :only => [:create, :destroy]
  resources :pictures, :only => [:create, :new]
  resources :js_challenges, :only =>[:show]
  resources :js_solutions, :only => [:create], :defaults => { :format => :json }
  resources :skeleton_answers, :only => [:create, :new]
  resources :sql_challenges, :only =>[:show]
  resources :sql_solutions, :only => [:create]
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