ActiveAdmin.register Language do
  # if you are using Rails 4 or Strong Parameters:
  #permit_params :id, :rank, :created_at, :updated_at, translations_attributes: [:id, :title, :description, :locale]
  permit_params :id, :name, :iso, :rank, :created_at, :updated_at
  
  filter :created_at

  index do
    # ...
    #translation_status
    # ...
    selectable_column
    column :id
    column :name
    column :iso
    column :rank
    column :created_at
    column :updated_at
    actions
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
