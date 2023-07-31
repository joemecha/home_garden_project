Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :gardens, only: %i[index show create update] do
        resources :locations, only: %i[index show create update]
      end
      resources :crops, only: %i[index show create update destroy]
      resources :notes, only: %i[index show create update destroy]
      resources :users, only: %i[create]
    end
  end
end
