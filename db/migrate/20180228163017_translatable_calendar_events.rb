class TranslatableCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        CalendarEvent.create_translation_table!({
          name: :string,
          description: :string
        }, {
          migrate_data: true
        })
      end

      dir.down do
        CalendarEvent.drop_translation_table! migrate_data: true
      end
    end
  end
end
