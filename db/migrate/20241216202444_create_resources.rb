class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources do |t|
      t.string :title, null: false
      t.text :description
      t.string :resource_type, null: false
      t.string :url
      t.references :goal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :tags do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :resource_tags do |t|
      t.references :resource, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tags, [:name, :user_id], unique: true
  end
end
