Crm::Application.routes.draw do

  scope '(:locale)' do

    # Import paths
    get 'contacts/import_step_1'  => 'contacts#import_step_1'
    post 'contacts/import_step_2' => 'contacts#import_step_2'
    post 'contacts/import_step_3' => 'contacts#import_step_3'    
    get 'tasks/import_step_1'  => 'tasks#import_step_1'
    post 'tasks/import_step_2' => 'tasks#import_step_2'
    post 'tasks/import_step_3' => 'tasks#import_step_3'
    get 'deals/import_step_1'  => 'deals#import_step_1'
    post 'deals/import_step_2' => 'deals#import_step_2'
    post 'deals/import_step_3' => 'deals#import_step_3'
    get 'events/import_step_1'  => 'events#import_step_1'
    post 'events/import_step_2' => 'events#import_step_2'
    post 'events/import_step_3' => 'events#import_step_3'

    mount Ckeditor::Engine => "/ckeditor"
    
    resources :stages, only: [:show]
    
    resources :events do
      post 'add_participant' => 'events#add_participant', as: "add_participant"
      get 'remove_participant/:participant_type/:participant_id' => 'events#remove_participant', as: "remove_participant"
      get 'change_status' => 'events#change_status', as: 'change_status'
      resources :tasks, except: [:index, :show]
      resources :histories, only: [:create, :destroy]      
    end
    
    resources :deals do
      post 'add_participant' => 'deals#add_participant', as: 'add_participant'
      get 'remove_participant/:participant_type/:participant_id' => 'deals#remove_participant', as: 'remove_participant'
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
  
    resources :authentications, only: [:destroy]
    #match '/auth/:provider/callback' => 'authentications#create'

    devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

    resources :users, only: [:edit, :update]
    get '/profile' => 'users#profile', as: 'profile'
    
    namespace :admin do
      resources :users
    end
    
    get '/search/(:search)' => 'search#index', as: 'search'
    
    match 'dashboard/index' => "dashboard#index", as: "dashboard"
  
    get 'options/index', as: 'options'
    get 'options/export', as: 'options_export'

    root :to => 'dashboard#index'
  end
end
