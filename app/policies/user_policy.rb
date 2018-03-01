class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def unlock?
    admin?
  end

  def destroy?
    admin? && record != user
  end

  def update?
    true
  end

  class Scope < Scope
    def resolve
      if admin?
        scope
      else
        scope.where(id: user.id)
      end
    end
  end
end