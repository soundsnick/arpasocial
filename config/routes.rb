Rails.application.routes.draw do
  devise_for :users
  get 'users/profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'home#index'
  get 'users/profile', as: 'user_root'
  get '/user/:username', to: 'users#index', as: 'profile'
  get '/user/:username/subscribe', to: 'users#subscribe', as: 'profile_subscribe'
  get '/new_publication', to: 'post#new_publication', as: :new_publication
  get '/profiles', to: 'users#profiles', as: :profiles

  post '/publish', to: 'post#publish', as: :new_post
  get '/post/:id/delete', to: 'post#delete', as: :post_delete
  get '/post/:id/like', to: 'post#like', as: :like
  get '/post/:id', to: 'post#index', as: :post_show
  post '/comment/:id', to: 'post#comment', as: :comment
  get '/comment/:id/delete', to: 'post#comment_delete', as: :comment_delete
end
