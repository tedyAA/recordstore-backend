class AddImageToRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :records, :image, :string, null: true
  end
end
