class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :place
      t.datetime :date
      t.string :notes
      t.string :type
			t.belongs_to :creator
      t.timestamps
    end
    #chiave-->eventi unici 
    add_index :events, %i[name place date], unique: true
  end
end
