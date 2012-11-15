class AddAttatchmentToPresentations < ActiveRecord::Migration
  def change
    add_attachment :presentations, :image
  end
end
