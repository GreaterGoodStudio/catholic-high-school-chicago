ActiveAdmin.register Intro do
  actions :all, :except => [:show]
  permit_params :id, :page, :image,
    translations_attributes: [:id, :locale, :copy]
  config.sort_order = "page_asc"
  
  index do
    column :page
    translation_status_flags
    actions
  end

  form do |f|
    f.inputs do
      f.input :page, as: :select, collection: Intro::ALLOWED_PAGES
      f.input :image, :hint => f.object.image.present? \
        ? image_tag(f.object.image.url(:thumb))
        : ""
    end

    f.inputs "Translated fields" do
      f.translated_inputs "ignored title", switch_locale: false do |t|
        t.input :copy, as: :trix_editor
      end
    end

    f.actions
  end
end