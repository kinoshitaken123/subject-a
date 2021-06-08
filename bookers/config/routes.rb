Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings',as: 'followings'
    get 'followers' => 'relationships#followers',as: 'followers'
    resource :rooms, only: [:create, :index, :show]
  end
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :book_comments, only: [:create, :destroy]
    end
  resources :rooms, :only => [:show, :index] do
  resources :chats, :only => [:create]
  end
  root 'homes#top'
  get '/home/about' => 'homes#about'
  get 'search' => 'search#search'

  get 'chat/:id' => 'chats#show', as: 'chat'
resources :chats, only: [:create]

end