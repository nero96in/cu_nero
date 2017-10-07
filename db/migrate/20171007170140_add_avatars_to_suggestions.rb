class AddAvatarsToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :avatars, :string
  end
end
