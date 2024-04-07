class AddColumnToToDo < ActiveRecord::Migration[6.0]
  def change
    add_column :to_dos, :status, :string
    add_reference :to_dos, :merchant, foreign_key: true
  end
end
