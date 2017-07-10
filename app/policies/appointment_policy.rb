class AppointmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def destroy?
    # AUTHORIZE IF USER IS OWNER OF THE APPOINTMENT OR HOST OF THE LINE
    if user == record.user || user == record.line.user
      return true
    end

    # AUTHORIZE IF USER IS AN ADMIN OF THE LINE
    record.line.administrators.each do |admin|
      if user == admin
        return true
      end
    end
  end
end
