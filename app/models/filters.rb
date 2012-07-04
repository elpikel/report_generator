require 'date'

class Filters
  attr_accessor :from, :to, :project

  def initialize params
    if params[:from].nil?
      @from = Date.today - 30
    else
      @from = Date.strptime(params[:from], "%Y-%m-%d")
    end

    if params[:to].nil?
      @to = Date.today
    else
      @to = Date.strptime(params[:to], "%Y-%m-%d")
    end

    @project = params[:project]
  end
end