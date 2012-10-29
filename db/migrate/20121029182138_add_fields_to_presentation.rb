class AddFieldsToPresentation < ActiveRecord::Migration
  def change
  	add_column :presentations, :description, :text
  	add_column :presentations, :guest_limit, :integer
  	add_column :presentations, :presentation_date, :dateTime
  end
end
