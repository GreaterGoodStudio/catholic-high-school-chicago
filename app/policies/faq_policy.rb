class FAQPolicy < ApplicationPolicy
  def destroy?
    admin?
  end

  def sort?
    admin?
  end
end