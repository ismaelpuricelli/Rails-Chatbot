Rails.application.routes.draw do
  get 'callback/index'
  post '/' => 'callback#received_data'

  get 'callback/received_data'

  root 'callback#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
