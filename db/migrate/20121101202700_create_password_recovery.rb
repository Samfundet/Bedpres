class CreatePasswordRecovery < ActiveRecord::Migration
  def up
    create_table :password_recoveries do |t|
      t.string     :recovery_hash
      t.references :user

      t.timestamps
    end
  end

  def down
    drop_table :password_recoveries
  end
end
