module ResourcesHelper
  def resource_type_classes(type)
    case type
    when 'book'
      'bg-blue-50 text-blue-700 ring-blue-600/20'
    when 'video'
      'bg-red-50 text-red-700 ring-red-600/20'
    when 'article'
      'bg-green-50 text-green-700 ring-green-600/20'
    when 'course'
      'bg-purple-50 text-purple-700 ring-purple-600/20'
    when 'link'
      'bg-yellow-50 text-yellow-700 ring-yellow-600/20'
    else
      'bg-gray-50 text-gray-700 ring-gray-600/20'
    end
  end
end
