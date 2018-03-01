class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :website
      t.string :application
      t.text   :description
      t.string :population_total
      t.string :population_yearly
      t.string :population_makeup
      t.string :tuition_cost
      t.string :tuition_merit
      t.string :tuition_assistance
      t.string :tuition_private
      t.string :tuition_info
      t.string :transportation_public
      t.string :transportation_bus
      t.string :transportation_l
      t.string :transportation_metra
      t.string :transportation_provided
      t.string :programming_support
      t.string :programming_academic
      t.string :programming_ap
      t.string :programming_extracurricular
      t.string :programming_athletic

      t.timestamps
    end
  end
end
