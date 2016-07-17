Rails.application.routes.draw do
  resources :posts
  get '/fetch', to: 'posts#fetch'
  get '/fetch_and_post', to: 'posts#fetch_and_post'
  get '/blog/create', to: 'blog_articles#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
