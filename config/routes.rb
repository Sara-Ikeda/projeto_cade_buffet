Rails.application.routes.draw do
  devise_for :owners, controllers: {
    registrations: 'owners/registrations', sessions: 'owners/sessions'
  }
  root "buffets#index"

  resources :buffets, only: [:show, :edit, :update, :new, :create] do
    get 'search', on: :collection
  end

  resources :events, only: [:new, :create] do
    resources :prices, only: [:new, :create]
  end
end
