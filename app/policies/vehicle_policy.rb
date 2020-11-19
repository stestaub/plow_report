# frozen_string_literal: true

class VehiclePolicy < ApplicationPolicy

  def create?
    company_admin_or_owner?(record.company)
  end

  def new?
    company_admin_or_owner?
  end

  def update?
    company_admin_or_owner?(record.company)
  end

  def destroy?
    company_admin_or_owner?(record.company)
  end

  def permitted_attributes
    [:name]
  end

  class Scope < Scope
    def resolve
      scope.where(company_id: auth_context.company)
    end
  end

end