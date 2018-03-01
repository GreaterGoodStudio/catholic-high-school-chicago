class AddShadowingLinkToSchool < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :shadowing_link, :string
    rename_column :schools, :tuition_info, :tuition_link
  end
end
