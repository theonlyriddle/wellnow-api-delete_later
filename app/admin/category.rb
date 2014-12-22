ActiveAdmin.register Category do
  # if you are using Rails 4 or Strong Parameters:
  permit_params :id, :rank, :created_at, :updated_at, translations_attributes: [:id, :title, :description, :locale]
  #permit_params :id, :rank, :created_at, :updated_at, :translations, :translations_attributes
  
  filter :created_at

  index do
    # ...
    #translation_status
    # ...
    selectable_column
    column :id
    column :rank
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
          t.input :title
          t.input :description
        end
    end

    f.inputs "Details" do
      f.input :rank
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :rank
      row :title
      # panel 'Globalized Model' do
      #   translate_attributes_table_for category_translations do
      #     row :title
      #     row :description
      #   end
      # end
    end 
  end


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


end
