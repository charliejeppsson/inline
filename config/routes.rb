Rails.application.routes.draw do

  get 'conversations/create'

  # CHAT FEATURE
  get 'home/index'
  resources :conversations, only: [:create]

  mount ActionCable.server => '/cable' # Serve web socket cable requests in process

  # ATTACHINARY
  mount Attachinary::Engine => "/attachinary"

  # ADMINISTRATORS:
  resources :administrators, only: [:new, :create, :destroy]

  # APPOINTMENTS:
  resources :appointments

  # LINES:
  resources :lines do
    get 'get_in_line', to: "lines#get_in_line"
  end

  get 'lines(/:line_id)(/make_admin/:user_id)', controller: 'lines', action: 'make_admin', as: 'line_make_admin'


  # USERS:
  get 'users/show'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # PAGES:
  root to: 'pages#home'

end
