# frozen_string_literal: true

# Apartment Type Policy for authorization
class ApartmentTypePolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    create?
  end

  def create?
    record.user.eql?(user) && allow_admin?
  end

  def edit?
    update?
  end

  def show?
    allow_admin?
  end

  def update?
    record.user.eql?(user) && allow_admin?
  end

  def destroy?
    allow_admin?
  end

  # Policy scope class
  class Scope < Scope
    def resolve
      scope.where(user_id: user&.id)
    end
  end
end
