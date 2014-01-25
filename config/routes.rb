Foodtruck::Application.routes.draw do
  resources :trucks
  root :to => 'trucks#index'
end
