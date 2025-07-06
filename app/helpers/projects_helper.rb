module ProjectsHelper
  def status_color(status)
    case status
    when 'pending'
      'warning'
    when 'in_progress'
      'primary'
    when 'completed'
      'success'
    when 'cancelled'
      'danger'
    else
      'secondary'
    end
  end
end
