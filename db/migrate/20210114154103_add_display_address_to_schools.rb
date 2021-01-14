class AddDisplayAddressToSchools < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :display_address, :text
  end
end
