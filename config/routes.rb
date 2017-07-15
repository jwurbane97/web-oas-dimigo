Rails.application.routes.draw do
 
  root 'plainpage#landing'
  
  get '/me' => 'plainpage#profile', as: :profile
  get '/teachers/requests' => 'plainpage#permission', as: :requests
  resources :applies do
    get 'print'
    post 'accept'
    post 'reject'
  end
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

end
