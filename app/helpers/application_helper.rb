module ApplicationHelper
  include Pagy::Frontend

  def alert_class(flash_type)
    case flash_type.to_sym
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :alert then "alert alert-warning"
    when :error then "alert alert-danger"
    end
  end

end
