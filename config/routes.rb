Rails.application.routes.draw do

  resources :records

  resources :projects do
    get :organize, on: :collection
  end

  resources :users

  get    'login' => 'sessions#new'
  post   'login' => 'sessions#create'
  delete 'login' => 'sessions#destroy'

  get 'about'   => 'home#about'
  get 'contact' => 'home#contact'

  root 'home#index'

end
