class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.date :borrowed_date
      t.date :return_date
      t.integer :book_id

      t.timestamps
    end
  end
end
