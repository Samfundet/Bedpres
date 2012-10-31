# This migration comes from samfundet_auth (originally 20121031220750)
class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles do |t|
      t.string     :name  # The name is a generic name of that type of role. E.g. «Gjengsjef» is a name.
      t.string     :title # The title of a role is unique and the properties gained from a role depends on its title. E.g. «mg_gjengsjef» is a title.
      t.text       :description
      t.boolean    :show_in_hierarchy, :default => false
      t.references :role
      t.references :group

      t.timestamps
    end
  end

  def down
    drop_table :roles
  end
end
