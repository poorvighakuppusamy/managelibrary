class RemoveBookIdFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :book_id, :integer
  end
end
