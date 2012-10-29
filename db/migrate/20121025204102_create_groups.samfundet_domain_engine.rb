# This migration comes from samfundet_domain_engine (originally 20121025025448)
class CreateGroups < ActiveRecord::Migration
  def up
    create_table :groups do |t|
      t.string     :name, :null => false
      t.string     :abbreviation
      t.text       :description, :null => false
      t.string     :website
      t.text       :short_description, :null => false
      t.text       :long_description, :null => false
      t.references :group_type, :foreign_key => { :dependent => :nullify }, :null => false

      t.timestamps
    end
  end

  def down
    drop_table :groups
  end
end
