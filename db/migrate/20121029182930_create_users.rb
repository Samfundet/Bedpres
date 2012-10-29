class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :firstname
      t.string :surname
      t.string :hashed_password

      t.timestamps
    end
  end
end