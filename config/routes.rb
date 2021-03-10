Rails.application.routes.draw do

  devise_for :users
  root 'notifications#index'
  get 'homes/top' => 'homes#top'
  get 'users/bookmark' => 'users#bookmark'
  get '/search' => 'searchs#search'

  resources :users
  resources :notifications, only: [:index]
  resources :items do
    resources :comments, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end
end
