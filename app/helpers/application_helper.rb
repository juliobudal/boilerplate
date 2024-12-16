module ApplicationHelper
  def goal_status_color(status)
    case status.to_s
    when 'not_started'
      'gray'
    when 'in_progress'
      'yellow'
    when 'completed'
      'green'
    else
      'gray'
    end
  end
end
