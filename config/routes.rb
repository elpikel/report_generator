ActionController::Routing::Routes.draw do |map|

 map.connect '/reporter', :controller => 'reporter', :action => 'index'
 map.connect '/reporter/create', :controller => 'reporter', :action => 'create'
 map.connect '/reporter/update', :controller => 'reporter', :action => 'update'
end
