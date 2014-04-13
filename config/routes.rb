Greenscreen::Application.routes.draw do
  resources :vehicle_models, path: '/vehicle-models'
  resources :vehicle_makes, path: '/vehicle-makes'

  get '/vehicle-models/model/:id', to: 'vehicle_models#show'
end
