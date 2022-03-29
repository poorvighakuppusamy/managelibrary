class User < ApplicationRecord
  belongs_to :role

  def is_user?
    role.name == 'User'
  end

  def is_admin?
    role.name == 'Admin'
  end

end
