# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :begin_year
      t.integer :end_year
      t.string :course_type
      t.string :material

      t.timestamps
    end
    add_index :courses, %i[name begin_year end_year], unique: true
  end
end
