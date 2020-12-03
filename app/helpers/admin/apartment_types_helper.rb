module Admin::ApartmentTypesHelper
  def is_default_type?(apartment_type)
    apartment_type&.name == 'default'
  end
end
