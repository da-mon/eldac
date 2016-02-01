Rails.application.routes.draw do

  resources :folders do
    get :ask_delete, on: :member
    post :organize, on: :collection
    post :save_sort, on: :collection
    post :toggle_collapse, on: :collection
  end

  resources :projects do
    get :ask_delete, on: :member
    get :organize, on: :collection
    post :toggle_folder, on: :collection
    post :checkall_folder, on: :collection
    post :assigned_folder, on: :collection
    
    resources :forms do
      post :save_sort, on: :collection
    end
  end

  resources :records
  resources :users

  get  'login'  => 'sessions#new'
  post 'login'  => 'sessions#create'
  get  'logout' => 'sessions#destroy'

  get 'about'   => 'home#about'
  get 'contact' => 'home#contact'

  root 'home#index'

end
