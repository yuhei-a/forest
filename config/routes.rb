Rails.application.routes.draw do
  root 'posts#top'
  get "/about" => "posts#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :posts
end
