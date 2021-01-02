Rails.application.routes.draw do
  root 'users#top'
  get "/about" => "users#about"
  get "posts/ranking", "posts#ranking"
  get "posts/image", "posts/image"
  get 'search' => 'searches#search'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resource :relationships, only: [:create, :destroy] do
    collection do
      get :following, :followed
    end
   end
   resources :chats, only: [:create,:show,:destroy]
   resources :notifications, only: [:index, :destroy]
  end
  resources :posts do
    resources :post_comments, only: [:create,:destroy]
    resources :tags do
      get 'posts', to: 'posts#search'
    end
    resource :likes, only: [:create, :destroy]
  end
end
