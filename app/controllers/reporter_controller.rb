class ReporterController < ApplicationController
  unloadable
  before_filter :require_login

  def index
    @filters = Filters.new(params)
    @user = User.current
    @entries = get_entries(@filters, @user)
    @entries_by_day = @entries.group_by(&:spent_on)
  end

  def sprint_report
    @filters = Filters.new(params)
    @user = User.current
    @report_items = get_report_items(@filters)
  end

  def generate_sprint_report
    @filters = Filters.new({:project => 1, :version => 1})
    @user = User.current
    @report_items = get_report_items @filters

    respond_to do |format|
      format.xls { response.headers['Content-Disposition'] = "attachment; filename=\"sprint_report.xls\"" }
    end
  end

  private

  def get_entries filters, user
    if filters.project.nil? || filters.project == ""
      conditions = ["#{TimeEntry.table_name}.user_id = ? AND #{TimeEntry.table_name}.spent_on BETWEEN ? AND ?",
                    user.id, filters.from, filters.to]
    else
      conditions = ["#{TimeEntry.table_name}.user_id = ? AND #{TimeEntry.table_name}.project_id = ? AND #{TimeEntry.table_name}.spent_on BETWEEN ? AND ?",
                    user.id, filters.project, filters.from, filters.to]
    end

    TimeEntry.find(:all,
                              :conditions => conditions,
                              :include => [:activity, :project, {:issue => [:tracker, :status]}],
                              :order => "#{TimeEntry.table_name}.spent_on DESC, #{Project.table_name}.name ASC, #{Tracker.table_name}.position ASC, #{Issue.table_name}.id ASC")
  end

  def get_report_items filters
    report_items = []

    if !filters.project.nil? && !filters.version.nil?
      report_items = Issue.find(:all, :conditions => ["#{Issue.table_name}.project_id = ? AND #{Issue.table_name}.fixed_version_id = ? ", filters.project, filters.version], :include => [:status])
    end

    report_items
  end

end
