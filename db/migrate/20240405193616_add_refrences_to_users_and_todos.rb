class AddRefrencesToUsersAndTodos < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :merchant, foreign_key: true
    add_reference :to_dos, :user, foreign_key: true

  end
end
