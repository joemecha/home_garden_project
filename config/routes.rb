Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :gardens, only: %i[index show create update]
      resources :locations, only: %i[index show create update]
      resources :crops, only: %i[index show create update destroy]
      resources :notes, only: %i[index show create update destroy]
    end
  end
end
