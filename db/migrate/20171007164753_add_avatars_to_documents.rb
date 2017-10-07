class AddAvatarsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :avatars, :string
  end
end
