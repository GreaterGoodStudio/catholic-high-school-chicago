class AddLatitudeAndLongitudeToSchool < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :latitude, :float
    add_column :schools, :longitude, :float
  end
end
