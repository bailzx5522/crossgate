ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :logged_exceptions
    admin.resources :users
    admin.root :controller => 'base'
  end
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
