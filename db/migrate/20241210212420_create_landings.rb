class CreateLandings < ActiveRecord::Migration[8.0]
  def change
    create_table :landings do |t|
      t.string :name
      t.json :content

      t.timestamps
    end
  end
end
