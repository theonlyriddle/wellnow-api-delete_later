ActiveAdmin.register Procedure do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  permit_params :id, :default_length, :category_id, :created_at, :updated_at, translations_attributes: [:id, :name, :locale]

  filter :category
  filter :doctors
  filter :default_length

  index do
    # ...
    #translation_status
    # ...
    selectable_column
    column :id
    column :name
    column :category
    column :default_length
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    # ...
    # f.translated_inputs "Translated fields", switch_locale: false do |t|
    #   t.input :title
    #   t.input :description
    # end
    f.inputs "Translations" do
        f.translate_inputs do |t|
          t.input :name
        end
    end

    f.inputs "Details" do
      f.input :category_id, :label => 'Category', :as => :select, :include_blank => true, :collection => Category.all.order('rank')
      f.input :default_length
    end

    f.actions
  end
end
