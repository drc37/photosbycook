ActionController::Routing::Routes.draw do |map|

  map.index 'index', :controller => "home", :action => :index
  
  map.root :index
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
