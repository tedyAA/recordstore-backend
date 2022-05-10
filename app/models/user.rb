class User < ApplicationRecord
  rolify
  has_secure_password
  has_many :records

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end
end
