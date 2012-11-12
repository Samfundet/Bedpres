class AddCanceledToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :canceled, :boolean
  end
end
