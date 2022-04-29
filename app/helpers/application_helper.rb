module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice
      "bg-blue-900 border-blue-900"
    when :success
      "bg-green-900 border-green-900"
    when :alert, :error
      "bg-red-900 border-red-900"
    else
      "bg-gray-900 border-blue-900"
    end
  end
end
