# frozen_string_literal: true

# creating enrollments table to tie up Courses and Students
# noinspection RailsParamDefResolve,RailsParamDefResolve
class CreateJoinTableEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_join_table :students, :courses, table_name: :enrollments do |t|
      t.index %i[student_id course_id], unique: true
    end
    add_foreign_key :enrollments, :students
    add_foreign_key :enrollments, :courses
  end
end
