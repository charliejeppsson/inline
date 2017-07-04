Rails.application.routes.draw do

  resources :appointments

  resources :lines do
    get 'get-in-line', to: "lines#get_in_line"
    get 'user-in-line', to: "lines#user_in_line"
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

end
