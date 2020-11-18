Rails.application.routes.draw do
  # devise_for :users, controllers: {registrations: "users_devise/registrations"}
  #devise_for :installs
  #devise_for :users, controllers: {omniauth_callbacks: :callbacks}
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  resources :microposts
  resources :users
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :password_resets, only: [:new, :create, :edit, :update]
  #resources :articles, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  #devise_for :users
  #resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles do
    resources :votes, only: [:create, :destroy]
  end
end
