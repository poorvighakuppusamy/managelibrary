class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
