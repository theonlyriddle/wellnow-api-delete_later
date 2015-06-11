ActiveAdmin.register User do


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

  permit_params :firstname, :lastname, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :firstname
    column :lastname
    column :email
    column :country
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :firstname
  filter :lastname
  filter :email
  filter :country
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :firstname
      f.input :lastname
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end


end
