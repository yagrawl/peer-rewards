Rails.application.routes.draw do
  namespace :api do
    resources :rewards, only: [:create]
  end
end
