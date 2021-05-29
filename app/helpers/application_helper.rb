module ApplicationHelper
  def flash_func(type)
    case type 
    when 'error'
      'alert-danger'
    when 'info'
      'alert-info'
    when 'success'
      'alert-success'
    when 'notice'
      'alert-info'
    end
  end
end
