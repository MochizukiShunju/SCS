Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  resources :items
  resources :users
end
