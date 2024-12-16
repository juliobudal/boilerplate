class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.string :status
      t.integer :progress
      t.references :study_area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
