ActiveAdmin.register School do
  actions :all, :except => [:show]
  config.sort_order = "name_asc"
  menu priority: 1

  permit_params :id, :name, :address, :phone, :website, 
    :tuition_cost, :tuition_link, :shadowing_link,
    :transportation_bus, :transportation_l, :transportation_metra, :transportation_options,
    translations_attributes: [
      :id,
      :locale,
      :application,
      :description,
      :population_total,
      :population_yearly,
      :population_makeup,
      :tuition_cost,
      :tuition_merit,
      :tuition_assistance,
      :tuition_private,
      :transportation_public,
      :transportation_bus,
      :transportation_l,
      :transportation_metra,
      :transportation_options,
      :transportation_provided,
      :programming_support,
      :programming_academic,
      :programming_ap,
      :programming_extracurricular,
      :programming_athletic
    ]

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    column :name
    column :address
    column :phone
    translation_status_flags
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address, input_html: { rows: 3 }
      f.input :phone
      f.input :website
      f.input :tuition_link
      f.input :shadowing_link
      f.input :tuition_cost
      f.input :transportation_bus, as: :text, input_html: { rows: 3 }
      f.input :transportation_l
      f.input :transportation_metra
    end

    f.inputs "Translated fields" do
      f.translated_inputs "ignored title", switch_locale: false do |t|
        t.input :application
        t.input :description, as: :trix_editor
        t.input :population_total
        t.input :population_yearly
        t.input :population_makeup
        t.input :tuition_merit
        t.input :tuition_assistance
        t.input :tuition_private
        t.input :transportation_public
        t.input :transportation_options
        t.input :transportation_provided
        t.input :programming_support
        t.input :programming_academic
        t.input :programming_ap
        t.input :programming_extracurricular
        t.input :programming_athletic
      end
    end

    f.actions
  end

  filter :name
end