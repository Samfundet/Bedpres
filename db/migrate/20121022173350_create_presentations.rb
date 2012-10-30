class CreatePresentations < ActiveRecord::Migration
  def up
    create_table :presentations do |t|
      t.string     :name
      t.references :area

      t.timestamps
    end
  end

  def down
    drop_table :presentations
  end
end
