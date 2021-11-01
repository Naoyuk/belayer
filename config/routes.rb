Rails.application.routes.draw do
  devise_for :users

  root to: 'posts#index'
  resources :posts
  resources :users
  resources :answers

  patch '/answers/:id/unread', action: :unread, controller: 'answers'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
