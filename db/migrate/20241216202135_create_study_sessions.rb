class CreateStudySessions < ActiveRecord::Migration[7.1]
  def change
    create_table :study_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :goal, null: false, foreign_key: true
      t.integer :duration_minutes, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.text :notes

      t.timestamps
    end

    add_index :study_sessions, [:user_id, :created_at]
  end
end
