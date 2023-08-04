Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

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

      resources :users, only: %i[show update destroy]
    end
  end
end
