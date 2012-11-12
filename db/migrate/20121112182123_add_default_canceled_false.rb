class AddDefaultCanceledFalse < ActiveRecord::Migration
  def up
    change_column :presentations, :canceled, :boolean, :default => false

    Presentation.update_all ["canceled = ?", false]
  end

  def down
    change_column :presentations, :canceled, :boolean, :default => nil
  end
end
