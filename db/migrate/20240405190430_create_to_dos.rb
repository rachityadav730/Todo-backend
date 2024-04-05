class CreateToDos < ActiveRecord::Migration[6.0]
  def change
    create_table :to_dos do |t|
      t.string :title
      t.text :description
      t.integer :creator_id
      t.integer :assign_user_id
      t.date :submission_date

      t.timestamps
    end
  end
end
