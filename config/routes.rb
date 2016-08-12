Rails.application.routes.draw do
  
  root 'home#index'
  
  # Authentication
  devise_for :users

  # Blog
  get 'blogs/new', to: 'blog#new'
  post 'blogs', to: 'blog#create'


  # Post


end
