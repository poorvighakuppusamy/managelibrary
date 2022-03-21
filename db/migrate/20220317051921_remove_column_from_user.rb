class RemoveColumnFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :borrowed_date, :date
    remove_column :users, :return_date, :date
  end
end
