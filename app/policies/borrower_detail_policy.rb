class BorrowerDetailPolicy < ApplicationPolicy
  def update?
    user.is_admin?
  end
end