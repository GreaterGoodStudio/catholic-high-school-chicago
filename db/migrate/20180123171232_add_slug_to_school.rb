class AddSlugToSchool < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :slug, :string

    School.reset_column_information
    School.find_each(&:save)
  end
end
