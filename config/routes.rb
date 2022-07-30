Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :bookings
    end
  end
end
