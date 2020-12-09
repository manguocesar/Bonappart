module Admin::ApartmentTypesHelper
  def is_default_type?(apartment_type)
    apartment_type&.name == Constant::DEFAULT_APARTMENT_TYPE
  end
end
