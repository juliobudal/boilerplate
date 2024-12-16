class AddIndexesToStudyAreasAndGoals < ActiveRecord::Migration[8.0]
  def change
    add_index :study_areas, :title
    add_index :goals, :title
    add_index :goals, :status
    add_index :goals, :due_date
  end
end
