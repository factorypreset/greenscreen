Greenscreen::Application.routes.draw do
  resources :vehicle_makes, path: '/vehicle-makes' do
    member do
      get 'statistics'
    end
    resources :vehicle_models, path: '/vehicle-models'
  end

end
