Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: 'products#index'
	#get 'logout', to: 'sessions#destroy', as: 'logout'
	#get 'login', to: 'sessions#new', as: 'login'
	#get 'signup', to: 'users#new', as: 'signup'

  resources :users, only: [ :new, :create]
	resources :sessions, only: [:new, :create, :destroy]
	resources :products do
		get 'search', on: :collection
  end

  resources :categories do
		get 'get_subcategories'
  end

  resources :shopping_cart, only: [:index, :destroy] do
		get 'add_to_cart', on: :member
  end
end
