Crm::Application.routes.draw do

  get 'dashboard/index' => "dashboard#index", as: "dashboard"

  scope '(:locale)' do
    resources :stages, only: [:show]
    
    resources :events do
      post 'add_participant' => 'events#add_participant', as: "add_participant"
      get 'remove_participant/:participant_type/:participant_id' => 'events#remove_participant', as: "remove_participant"
      get 'change_status' => 'events#change_status', as: 'change_status'
      resources :tasks, except: [:index, :show]
      resources :histories, only: [:create, :destroy]      
    end
    
    resources :deals do
      post 'add_participant' => 'deals#add_participant', as: "add_participant"
      get 'remove_participant/:participant_type/:participant_id' => 'deals#remove_participant', as: "remove_participant"
      resources :tasks, except: [:index, :show]
      resources :histories, only: [:create, :destroy]
    end

    resources :tasks, except: [:show]
    
    resources :contacts, only: [:index]
    
    resources :people do
      resources :deals, except: [:index]
      resources :tasks, except: [:index, :show]
      resources :histories, only: [:create, :destroy]
    end
    
    resources :companies do
      post 'add_person' => 'companies#add_person', as: "add_person"
      resources :deals, except: [:index]    
      resources :tasks, except: [:index, :show]
      resources :histories, only: [:create, :destroy]
    end
  
    devise_for :users
    resources :users, only: [:edit, :update]
    get '/profile' => 'users#profile', as: 'profile'
    namespace :admin do
      resources :users
    end
    
    get '/search/(:search)' => 'search#index', as: 'search'
    
    root :to => 'dashboard#index'
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
