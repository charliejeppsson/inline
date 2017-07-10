class LinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def update?
    user_is_host?
  end

  def destroy?
    user_is_host?
  end

  def make_admin?
    user_is_host?
  end

  def get_in_line?
    return true
  end

  private

  def user_is_host?
    record.user == user
  end
end
