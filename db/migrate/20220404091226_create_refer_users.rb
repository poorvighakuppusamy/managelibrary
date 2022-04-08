class CreateReferUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :refer_users do |t|
      t.string :email

      t.timestamps
    end
  end
end
