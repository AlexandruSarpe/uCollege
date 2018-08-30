# frozen_string_literal: true

# creating reservations table
class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.string :typeReservation
      t.string :firstCourseAlternatives
      t.string :secondCourseAlternatives
      t.string :sideDishAlternatives
      t.string :notes
      t.belongs_to :student, index: true
      t.belongs_to :menu, index: true

      t.timestamps
    end
		add_index :reservations, %i[menu student], unique: true
  end
end
