class AddAvatarsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :avatars, :string
  end
end
