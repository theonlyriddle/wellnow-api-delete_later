ActiveAdmin.register Category do
  # if you are using Rails 4 or Strong Parameters:
  permit_params :id, :rank, :created_at, :updated_at, translations_attributes: [:id, :title, :description, :locale]

  


  index do
    # ...
    translation_status
    # ...
    default_actions
  end

  form do |f|
    # ...
    f.translated_inputs "Translated fields", switch_locale: false do |t|
      t.input :title
      t.input :description
    end

    f.inputs "Details" do
      f.input :rank
    end

    f.actions
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