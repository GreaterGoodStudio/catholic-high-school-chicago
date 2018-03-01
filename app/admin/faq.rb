ActiveAdmin.register FAQ do
  actions :all, :except => [:show]
  permit_params :id, :position,
    translations_attributes: [:id, :locale, :question, :answer]

  config.sort_order = "position_asc"
  config.paginate   = false
  
  orderable

  index do
    orderable_handle_column
    column :question
    translation_status_flags
    actions
  end

  form do |f|
    f.inputs "Translated fields" do
      f.translated_inputs "ignored title", switch_locale: false do |t|
        t.input :question
        t.input :answer, as: :trix_editor
      end
    end

    f.actions
  end

  filter :question
  filter :answer
end