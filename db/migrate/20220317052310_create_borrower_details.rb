class CreateBorrowerDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :borrower_details do |t|
      t.integer :user_id
      t.integer :book_id
      t.date :borrowed_date
      t.date :return_date
      t.string :status

      t.timestamps
    end
  end
end
