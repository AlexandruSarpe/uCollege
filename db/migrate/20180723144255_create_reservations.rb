# frozen_string_literal: true

# creating reservations table
class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :guestNumber
      t.string :FirstCourseAlternatives
      t.string :SecondCourseAlternatives
      t.string :SideDishAlternatives
      t.string :notes
      t.belongs_to :reservationStudent, index: true
      t.belongs_to :reservationMenu, index: true

      t.timestamps
    end
    add_index :reservations, %i[reservationStudent reservationMenu], unique: true
  end
end
