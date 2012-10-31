# This migration comes from samfundet_auth (originally 20121031220820)
class CreateMembersRoles < ActiveRecord::Migration
  def up
    create_table :members_roles do |t|
      t.references :member
      t.references :role
    end
  end

  def down
    drop_table :members_roles
  end
end
