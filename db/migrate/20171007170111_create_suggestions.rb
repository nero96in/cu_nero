class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :title
      t.text :content
      t.integer  :user_id

      t.timestamps null: false
    end
  end
end
