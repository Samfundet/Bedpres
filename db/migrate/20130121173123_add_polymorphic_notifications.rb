class AddPolymorphicNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :user_id
    add_column :notifications, :notifiable_type, :string
    add_column :notifications, :notifiable_id, :integer
  end
end
