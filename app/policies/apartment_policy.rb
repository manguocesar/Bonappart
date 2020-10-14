# frozen_string_literal: true

class ApartmentPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    create?
  end

  def create?
    allow_admin_or_landlord?
  end

  def edit?
    update?
  end

  def show?
    true
  end

  def update?
    allow_admin_or_landlord?
  end

  def destroy?
    allow_admin_or_landlord?
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user&.id)
    end
  end
end
