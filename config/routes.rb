Rails.application.routes.draw do
  # devise_for :users
  Rails.application.routes.draw do
    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users, only: %i[index show] do
        resources :posts, only: %i[index] do
          resources :comments, only: %i[index create] do
          end
        end
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[new create]
    end
  end

  # Defines the root path route ("/")
  root "users#index"
end
