Rails.application.routes.draw do

  root 'homes#top'
  get 'home/about' => 'homes#about'
  
  resources :books, only: [:edit, :index, :show]
  resources :users, only: [:index, :show, :edit]
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
