ActiveAdmin.register Scholarship do
  actions :all, :except => [:show]
  permit_params :id, :name, :website,
    translations_attributes: [:id, :locale, :description]

  config.sort_order = "name_asc"
  
  index do
    column :name
    translation_status_flags
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :website
    end

    f.inputs "Translated fields" do
      f.translated_inputs "ignored title", switch_locale: false do |t|
        t.input :description, as: :trix_editor
      end
    end

    f.actions
  end

  filter :name
  filter :description
end