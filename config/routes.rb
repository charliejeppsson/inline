Rails.application.routes.draw do

  get 'messages/create'

  get 'conversations/create'

  # Action cable chat feature
  get 'home/index'

  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end

  mount ActionCable.server => '/cable' # Serve web socket cable requests in process

  # Administrators
  resources :administrators, only: [:new, :create, :destroy]

  # Appointments
  resources :appointments

  # Lines
  resources :lines do
    get 'get_in_line', to: "lines#get_in_line"
  end

  get 'lines(/:line_id)(/make_admin/:user_id)', controller: 'lines', action: 'make_admin', as: 'line_make_admin'


  # Users
  get 'users/show'

  # To a) customize user registrations and account updates so that first and last names are also included
  # and b) allow for facebook API registrations
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  # Pages
  root to: 'pages#home'

  # For support of background jobs when in production
  Rails.application.routes.draw do
    # Sidekiq Web UI, only for admins.
    require "sidekiq/web"
    authenticate :user, lambda { |u| u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

end
