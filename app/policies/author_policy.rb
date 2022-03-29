class AuthorPolicy < ApplicationPolicy
  def create?
    user.is_admin?
  end
end
