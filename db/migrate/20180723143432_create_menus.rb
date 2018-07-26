# frozen_string_literal: true

# creating menus table
class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.date :date
      t.string :mealType
      t.string :firstCourse
      t.string :secondCourse
      t.string :sideDish
      t.string :notes
      t.belongs_to :canteen, index: true

      t.timestamps
    end
    add_index :menus, %i[date mealType], unique: true
  end
end
