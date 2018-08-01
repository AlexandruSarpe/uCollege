class CreateForms < ActiveRecord::Migration[5.2]
  def change
    create_table :forms do |t|
      t.date :dateStart
      t.date :dateEnd
      t.string :linkToForm
      t.string :linkToResult
      t.belongs_to :canteen, index: true

      t.timestamps
    end
  end
end
