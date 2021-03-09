Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'
  get 'users/bookmark' => 'users#bookmark'
  get '/search' => 'searchs#search'

  resources :items do
    resources :comments, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :users
end
