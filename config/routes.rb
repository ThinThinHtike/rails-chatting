Rails.application.routes.draw do
  get 'users/show'
  resources :rooms do
    resources :messages
  end
  root 'pages#home'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  get 'user/:id', to: "users#show", as: "user"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
