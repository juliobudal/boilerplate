module GoalsHelper
  def status_color(status)
    case status
    when 'not_started'
      'bg-gray-50 text-gray-600 ring-gray-500/10'
    when 'in_progress'
      'bg-yellow-50 text-yellow-800 ring-yellow-600/20'
    when 'completed'
      'bg-green-50 text-green-700 ring-green-600/20'
    else
      'bg-gray-50 text-gray-600 ring-gray-500/10'
    end
  end
end
