Rails.application.routes.draw do
  get 'post_comments/create'
  get 'likes/create'
  root 'users#top'
  get "/about" => "users#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :posts do
    resources :post_comments, only: [:create,:destroy]
    resource :likes, only: [:create, :destroy]
  end
end
