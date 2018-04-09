Rails.application.routes.draw do
  get 'static_pages/home'

  devise_for :users, controllers: {
      registrations: 'user/registrations'
  }
  resources :drives
  resources :standby_dates, only: [:create, :destroy, :index]
  resources :standby_date_ranges, only: :create

  resources :companies do
    scope module: 'company' do
      resources :drives, only: [:index, :destroy]
      resources :standby_dates, only: [:index, :destroy, :create] do
        collection do
          get :weeks
        end
      end
      resources :company_members, only: [:create, :index, :destroy, :update]
      resources :drivers, only: [:index, :create, :destroy]
    end
  end

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
