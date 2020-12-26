Rails.application.routes.draw do
  root 'users#top'
  get "/about" => "users#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resource :relationships, only: [:create, :destroy] do
    collection do
      get :following, :followed
    end
   end
   resources :chats, only: [:create,:show,:destroy]
  end
  resources :posts do
    resources :post_comments, only: [:create,:destroy]
    resource :likes, only: [:create, :destroy]
  end
end
