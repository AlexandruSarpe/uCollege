# frozen_string_literal: true

# canteen user
class Canteen < User
  acts_as_user roles: :canteen

  has_many :writes, class_name: 'Menu', foreign_key: 'add_index', dependent: :delete_all
end
