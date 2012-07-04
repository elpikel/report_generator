class ReporterController < ApplicationController
  unloadable
  before_filter :require_login

  def index
    @filters = Filters.new(:from => params[:from], :to => params[:to], :project => params[:project])
    @user = User.current
    if @filters.project.nil?
      conditions = ["#{TimeEntry.table_name}.user_id = ? AND #{TimeEntry.table_name}.spent_on BETWEEN ? AND ?",
                    @user.id, @filters.from, @filters.to]
    else
      conditions = ["#{TimeEntry.table_name}.user_id = ? AND #{TimeEntry.table_name}.project_id = ? AND #{TimeEntry.table_name}.spent_on BETWEEN ? AND ?",
                    @user.id, @filters.project, @filters.from, @filters.to]
    end
    @entries = TimeEntry.find(:all,
                              :conditions => conditions,
                              :include => [:activity, :project, {:issue => [:tracker, :status]}],
                              :order => "#{TimeEntry.table_name}.spent_on DESC, #{Project.table_name}.name ASC, #{Tracker.table_name}.position ASC, #{Issue.table_name}.id ASC")

    @entries_by_day = @entries.group_by(&:spent_on)
  end

end
