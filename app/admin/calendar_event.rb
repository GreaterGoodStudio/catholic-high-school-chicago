ActiveAdmin.register CalendarEvent do
  actions :all, :except => [:show]
  permit_params :id, :starts_at, :ends_at, :school_id,
    translations_attributes: [:id, :locale, :name, :description]

  config.sort_order = "starts_at_desc"
  
  index do
    column :name
    column :starts_at
    column :ends_at
    column :school
    translation_status_flags
    actions
  end

  form do |f|
    f.inputs do
      f.input :school
      f.input :starts_at, as: :string, input_html: { class: "datetime datetime_start", placeholder: "Select a date and time" }
      f.input :ends_at, as: :string, input_html: { class: "datetime datetime_end", placeholder: "Select a date and time" }
    end

    f.inputs "Translated fields" do
      f.translated_inputs "ignored title", switch_locale: false do |t|
        t.input :name
        t.input :description, as: :trix_editor
      end
    end

    f.actions
  end

  filter :name
  filter :school
end