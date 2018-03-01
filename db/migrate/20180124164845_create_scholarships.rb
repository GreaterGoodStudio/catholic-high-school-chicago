class CreateScholarships < ActiveRecord::Migration[5.1]
  def change
    create_table :scholarships do |t|
      t.string :name
      t.text :description
      t.string :website

      t.timestamps
    end
  end
end
