module DashboardHelper

  def change_string_to_param(type)
    type.parameterize.underscore.to_sym
  end

end
