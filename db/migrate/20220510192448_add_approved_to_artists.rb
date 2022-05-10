class AddApprovedToArtists < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :approved, :boolean, default: false, null: true
  end
end
