class AddSocialMediaToSchools < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :facebook_link, :string
    add_column :schools, :instagram_link, :string
    add_column :schools, :twitter_link, :string
  end
end
