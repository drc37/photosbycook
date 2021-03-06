ActionController::Routing::Routes.draw do |map|
  map.resources :home, :collection => [:refresh, :images]

  map.root :controller => "home"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
