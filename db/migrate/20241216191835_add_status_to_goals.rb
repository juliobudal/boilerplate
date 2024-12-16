class AddStatusToGoals < ActiveRecord::Migration[7.1]
  def up
    # First remove the existing status column if it's a string
    remove_column :goals, :status

    # Add it back as an integer with default value
    add_column :goals, :status, :integer, default: 0, null: false
  end

  def down
    remove_column :goals, :status
    add_column :goals, :status, :string
  end
end
