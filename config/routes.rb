Rails.application.routes.draw do
  
  root 'home#index'
  
  # Authentication
  devise_for :users

  # Blog
  get 'blogs/new', to: 'blog#new'
  post 'blogs', to: 'blog#create'

  # CRUD Posts
  get '/:slug', to: 'posts#index', as: 'posts'
  get '/:slug/rss', to: 'posts#feed', as: 'posts_rss'

  get 'blogs/:slug/posts/new', to: 'posts#new', as: 'new_post'
  post 'blogs/:slug/posts', to: 'posts#create', as: 'create_post'
  
  get '/:slug/:id', to: 'posts#edit', as: 'edit_post'
  patch '/:slug/:id', to: 'posts#update', as: 'update_post'

  delete '/:slug/:id', to: 'posts#destroy', as: 'delete_post'

  # Comments
  get '/:slug/:id/comments', to: 'comments#index', as: 'comments'
  get '/:slug/:id/comments', to: 'comments#new', as: 'new_comments'
  post '/:slug/:id/comments', to: 'comments#create', as: 'create_comments'

end