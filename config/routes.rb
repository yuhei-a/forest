Rails.application.routes.draw do
  root 'users#top'
  get "/about" => "users#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :posts
end
