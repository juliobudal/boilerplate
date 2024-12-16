class CreateStudyAreas < ActiveRecord::Migration[8.0]
  def change
    create_table :study_areas do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
