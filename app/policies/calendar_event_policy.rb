class CalendarEventPolicy < ApplicationPolicy
  def destroy?
    admin?
  end
end
