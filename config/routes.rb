Rails.application.routes.draw do

  #devise_for :clients
  mount Hyperstack::Engine => '/hyperstack'
  match '/(*other)', via: [:get, :post], to: 'hyperstack#App'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
