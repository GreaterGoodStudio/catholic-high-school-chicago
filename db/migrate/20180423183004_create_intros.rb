class CreateIntros < ActiveRecord::Migration[5.1]
  def change
    create_table :intros do |t|
      t.string :page
      t.text :copy
      t.string :image

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Intro.create_translation_table!({
          copy: :string,
        }, {
          migrate_data: true
        })
      end

      dir.down do
        Intro.drop_translation_table! migrate_data: true
      end
    end
  end
end
