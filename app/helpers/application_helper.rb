module ApplicationHelper
  def errors_count_format(object)
    size = object.errors.size
    errors = "error".pluralize(size)
    "#{size} #{errors}"
  end
end
