class RemoveProgressFromGoals < ActiveRecord::Migration[7.1]
  def change
    remove_column :goals, :progress, :integer
  end
end
