Greenscreen::Application.routes.draw do
  resources :vehicle_makes, path: '/vehicle-makes' do
    resources :vehicle_models, path: '/vehicle-models'
  end

end
