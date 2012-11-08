class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :presentation
      t.references :user
      t.timestamps
    end
  end
end
