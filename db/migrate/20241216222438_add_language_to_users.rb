class AddLanguageToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :language, :string, default: 'en'
    add_index :users, :language
  end
end
