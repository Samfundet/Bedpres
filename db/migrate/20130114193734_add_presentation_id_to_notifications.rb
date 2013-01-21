class AddPresentationIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :presentation_id, :integer
  end
end
