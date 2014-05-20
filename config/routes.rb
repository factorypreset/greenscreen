Greenscreen::Application.routes.draw do
  get 'vehicle-makes/statistics', to: 'vehicle_makes#index_statistics'
  resources :vehicle_makes, path: '/vehicle-makes' do
    member do
      get 'statistics'
    end
    resources :vehicle_models, path: '/vehicle-models'
  end

end
