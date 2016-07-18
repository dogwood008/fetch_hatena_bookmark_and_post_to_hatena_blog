Rails.application.routes.draw do
  get '/fetch', to: 'posts#fetch'
  get '/fetch_and_post', to: 'posts#fetch_and_post'
end
