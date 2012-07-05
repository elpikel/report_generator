require 'redmine'
require 'csv'
Mime::Type.register "application/xls", :xls
Redmine::Plugin.register :redmine_reporter do
  name 'Redmine Repoter plugin'
  author 'Arkadiusz Plichta'
  description 'Reporting plugin for Redmine'
  version '0.0.1'
  url 'http://www.soon.com'
  author_url 'http://www.soon.com/'

  
  permission :reporter, { :reporter => [:index] }, :public => true
  menu :top_menu, :reporter, { :controller => 'reporter', :action => 'index' }, { :caption => 'Reports', :after => :help }
end




