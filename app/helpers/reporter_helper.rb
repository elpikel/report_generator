module ReporterHelper
  def render_project_box selected_project
    return unless User.current.logged?
    projects = User.current.memberships.collect(&:project).compact.uniq
    if projects.any?
      s = '<select name="project">'
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
end
