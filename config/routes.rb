Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      resources :background, only: [:index]
      get 'book-search', to: 'books#index'
    end
  end
end
