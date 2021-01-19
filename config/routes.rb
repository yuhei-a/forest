Rails.application.routes.draw do
  root 'users#top'
  get '/about' => 'users#about'
  get 'posts/ranking' => 'posts#ranking'
  get 'users/image' => 'users#image'
  get 'posts/image' => 'posts#image'
  get 'search' => 'searches#search'
  get 'unsubscribe/:name' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch ':id/withdraw/:name' => 'users#withdraw', as: 'withdraw_user'
  put 'withdraw/:name' => 'users#withdraw'
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

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
    resources :tags do
      get 'posts', to: 'posts#search'
    end
    resource :likes, only: [:create, :destroy]
  end
end
