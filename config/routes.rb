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
  end

  resources :events, only: [:new, :create, :edit, :update] do
    resources :prices, only: [:new, :create, :edit, :update]
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
