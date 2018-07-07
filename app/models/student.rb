# frozen_string_literal: true

# student user
class Student < User
  acts_as_user roles: :student
  has_and_belongs_to_many :courses, join_table: 'enrollments'
end
