ActionController::Routing::Routes.draw do |map|
 map.connect '/reporter', :controller => 'reporter', :action => 'index'
 map.connect '/reporter/sprint', :controller => 'reporter', :action => 'sprint_report'
 map.connect '/reporter/generate/sprint', :controller => 'reporter', :action => 'generate_sprint_report'
end
