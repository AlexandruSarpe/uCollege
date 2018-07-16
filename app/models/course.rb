# frozen_string_literal: true

# course model
class Course < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :begin_year
  validates_presence_of :end_year
  has_and_belongs_to_many :students, join_table: 'enrollments'
  before_destroy {students.clear}
end
