Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  get 'posts/new', to: 'posts#new'
  post 'posts', to: 'posts#create'
  post 'comments/:post_id', to: 'comments#create'
  post 'likes/:post_id', to: 'likes#create'
  
  root to: "users#index"
end