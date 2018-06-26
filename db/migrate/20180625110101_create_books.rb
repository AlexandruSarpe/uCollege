class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author
      t.string :owner
      t.string :current_owner

      t.timestamps
    end
  end
end
