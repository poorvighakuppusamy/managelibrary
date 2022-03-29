class RenameColumnDescription < ActiveRecord::Migration[5.0]
  def change
    rename_column :authors, :Description, :description
  end
end
