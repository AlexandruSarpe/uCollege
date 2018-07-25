# frozen_string_literal: true

# student user
class Student < User
  acts_as_user roles: :student

  has_many :studentReservation, class_name: 'Reservation', foreign_key: 'add_index', dependent: :delete_all
  has_many :owned_books, class_name: 'Book', foreign_key: 'owner_id', dependent: :delete_all
  has_many :borrowed_books, class_name: 'Book', foreign_key: 'current_owner_id', dependent: :delete_all
  has_and_belongs_to_many :courses, join_table: 'enrollments'
  before_destroy {courses.clear}
end
