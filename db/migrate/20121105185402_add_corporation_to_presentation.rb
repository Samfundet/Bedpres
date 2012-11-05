class AddCorporationToPresentation < ActiveRecord::Migration
  def change
    add_column :presentations, :corporation, :string
  end
end
