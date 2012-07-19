Crm::Application.routes.draw do

  scope '(:locale)' do

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
    get 'tasks/import_step_1'  => 'tasks#import_step_1'
    post 'tasks/import_step_2' => 'tasks#import_step_2'
    post 'tasks/import_step_3' => 'tasks#import_step_3'
    
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
    match '/auth/:provider/callback' => 'authentications#create'
    
    devise_for :users
    resources :users, only: [:edit, :update]
    get '/profile' => 'users#profile', as: 'profile'
    
    namespace :admin do
      resources :users
    end
    
    get '/search/(:search)' => 'search#index', as: 'search'
    get '/search/(:type)/(:search)' => 'search#all', as: 'search_all'
    
    match 'dashboard/index' => "dashboard#index", as: "dashboard"
    
    root :to => 'dashboard#index'
  end
end
