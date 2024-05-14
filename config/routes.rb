Rails.application.routes.draw do
  resources :kinds

  resources :contacts do
    resource :kind, only: [:show]
    resource :kind, only: [:show], path: 'relationships/kind'

    resource :phones, only: [:show]
    resource :phones, only: [:show], path: 'relationships/phones'

    resource :address, only: [:show]
    resource :address, only: [:show], path: 'relationships/address'

    
  end
  get "up" => "rails/health#show", as: :rails_health_check
end

