class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.string :author
      t.belongs_to :owner, index: true
      t.belongs_to :current_owner, index: true

      t.timestamps
    end
  end
end
