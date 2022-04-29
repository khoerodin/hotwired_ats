module ApplicationHelper
  # rubocop:disable Metrics/MethodLength
  def flash_class(level)
    case level.to_sym
    when :notice
      "bg-blue-900 border-blue-900"
    when :success
      "bg-green-900 border-green-900"
    when :alert
      "bg-red-900 border-red-900"
    when :error
      "bg-red-900 border-red-900"
    else
      "bg-blue-900 border-blue-900"
    end
  end
  # rubocop:enable Metrics/MethodLength
end
