Rails.application.routes.draw do
  get 'bookings/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'bookings#index'
end