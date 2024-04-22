Rails.application.routes.draw do
  devise_for :owners, controllers: {
    registrations: 'owners/registrations', sessions: 'owners/sessions'
  }
  root "home#index"

  resources :buffets, only: [:index, :show, :edit, :update, :new, :create]
  resources :events, only: [:new, :create]
end
