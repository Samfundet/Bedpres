class AddPolymorphicParticipations < ActiveRecord::Migration
  def change
    remove_column :participations, :user_id
    add_column :participations, :participle_type, :string
    add_column :participations, :participle_id, :integer
  end
end
