Rails.application.routes.draw do
  root 'home#index'
  resources :posts
  resources :admin, only: %i[index]
end
