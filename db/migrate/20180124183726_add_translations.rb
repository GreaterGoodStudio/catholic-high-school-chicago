class AddTranslations < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        FAQ.create_translation_table!({
          question: :string,
          answer: :text
        }, {
          migrate_data: true
        })

        Scholarship.create_translation_table!({
          description: :text
        }, {
          migrate_data: true
        })

        School.create_translation_table!({
          application: :string,
          description: :text,
          population_total: :string,
          population_yearly: :string,
          population_makeup: :string,
          tuition_cost: :string,
          tuition_merit: :string,
          tuition_assistance: :string,
          tuition_private: :string,
          transportation_public: :string,
          transportation_bus: :string,
          transportation_l: :string,
          transportation_metra: :string,
          transportation_provided: :string,
          programming_support: :string,
          programming_academic: :string,
          programming_ap: :string,
          programming_extracurricular: :string,
          programming_athletic: :string,
        }, {
          migrate_data: true
        })
      end

      dir.down do
        FAQ.drop_translation_table! migrate_data: true
        Scholarship.drop_translation_table! migrate_data: true
        School.drop_translation_table! migrate_data: true
      end
    end
  end
end
