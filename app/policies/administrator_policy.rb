class AdministratorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def destroy?
    record.user == user
  end
end
