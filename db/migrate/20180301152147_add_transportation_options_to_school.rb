class AddTransportationOptionsToSchool < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :transportation_options, :string
    add_column :school_translations, :transportation_options, :string
  end
end
