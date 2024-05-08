Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: 'customers/registrations', sessions: 'customers/sessions'
  }
  
  devise_for :owners, controllers: {
    registrations: 'owners/registrations', sessions: 'owners/sessions'
  }
  
  root "buffets#index"

  resources :buffets, only: [:show, :edit, :update, :new, :create] do
    get 'search', on: :collection
    get 'order_index', on: :collection
    get 'order_show', on: :member
  end

  resources :events, only: [:new, :create] do
    resources :prices, only: [:new, :create]
    resources :orders, only: [:new, :create]
  end

  resources :orders, only: [:index, :show] do
    resources :order_budgets, only: [:new, :create]
    get 'confirm', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :buffets, only: [:index, :show] do
        resources :events, only: [:index] do
          get 'query', on: :member
        end
      end
    end
  end
end
