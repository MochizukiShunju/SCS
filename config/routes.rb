Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  resources :items do
    resources :comments, only: [:create, :destroy]
  end
  resources :users
end
