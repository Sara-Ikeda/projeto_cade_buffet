Rails.application.routes.draw do
  root "home#index"

  resources :buffets, only: [:index, :show, :edit, :update]
end
