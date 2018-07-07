# frozen_string_literal: true

# course model
class Course < ApplicationRecord
  has_and_belongs_to_many :students, join_table: 'enrollments'
end
