Rails.application.routes.draw do
  root 'hyperstack#app' #'hyperstack#HelloWorld'
  mount Hyperstack::Engine => '/hyperstack'

  resources :clients do
    resources :search_profiles do
      get :aspects, to: 'hyperstack#aspects'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
