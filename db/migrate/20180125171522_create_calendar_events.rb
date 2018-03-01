class CreateCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :calendar_events do |t|
      t.string :name
      t.string :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
