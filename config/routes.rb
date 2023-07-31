Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :gardens, only: %i[index show create update] do
        resources :locations, only: %i[index show create update]
      end

      resources :locations, only: %i[none] do
          resources :crops, only: %i[index show create update destroy]
      end

      resources :crops, only: %i[none] do
        resources :notes, only: %i[index show create update destroy]
      end

      resources :users, only: %i[create]
    end
  end
end
