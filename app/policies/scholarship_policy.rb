class ScholarshipPolicy < ApplicationPolicy
  def destroy?
    admin?
  end
end
