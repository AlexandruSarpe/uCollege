# frozen_string_literal: true

# canteen user
class Canteen < User
  acts_as_user roles: :canteen

  has_many :menus, dependent: :delete_all
  has_many :forms, dependent: :delete_all
end
