Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'questions#index'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  resources :questions do
    resources :answers, only: [:create, :edit, :update, :destroy]
    resources :votes, only: [:create, :update, :destroy]
  end

  resources :answers, only: [] do
    resources :votes, only: [:create, :update, :destroy]
  end
end
