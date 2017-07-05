Rails.application.routes.draw do

  get 'users/show'

  resources :administrators, only: [:new, :create, :destroy]

  resources :appointments

  # We want to take make-admin from route lines/72/make-admin to: lines/12/users/index/72/make_admin

  resources :lines do
    get 'get-in-line', to: "lines#get_in_line"
    # get 'user-in-line', to: "lines#user_in_line"
    # get 'make-admin', to: "lines#make_admin"
    resources :users, only: [:index] do
      get 'make-admin'
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

end
