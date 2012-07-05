module ReporterHelper
  def render_project_box selected_project
    return unless User.current.logged?
    projects = User.current.memberships.collect(&:project).compact.uniq
    if projects.any?
      s = '<select name="project">'
      s << "<option value=""></option>"
      projects.each { |p|
        if p.id.to_s == selected_project.to_s
          s << "<option value=\""+p.id.to_s+"\" selected>"+p.name+"</option>"
        else
          s << "<option value=\""+p.id.to_s+"\">"+p.name+"</option>"
        end
      }
      s << '</select>'
      s.html_safe
    end
  end

  def render_sprint_box selected_project, selected_sprint
    return unless User.current.logged?
    versions = Version.find(:all, :conditions => ["#{Version.table_name}.project_id = ?", selected_project])
    if versions.any?
      s = '<select name="version">'
      s << "<option value=""></option>"
      versions.each { |p|
        if p.id.to_s == selected_sprint.to_s
          s << "<option value=\""+p.id.to_s+"\" selected>"+p.name+"</option>"
        else
          s << "<option value=\""+p.id.to_s+"\">"+p.name+"</option>"
        end
      }
      s << '</select>'
      s.html_safe
    end
  end
end
