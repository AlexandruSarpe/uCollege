# frozen_string_literal: true

# student user
class Student < User
  acts_as_user roles: :student

  has_many :owned_books, class_name: 'Book', foreign_key: 'owner_id'
  has_many :borrowed_books, class_name: 'Book', foreign_key: 'current_owner_id'
  
  has_and_belongs_to_many :courses, join_table: 'enrollments'
end
