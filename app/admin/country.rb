ActiveAdmin.register Country do
  remove_filter :doctors

  permit_params :id, :name, :iso, :default, :default_time_zone, :created_at, :updated_at

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

  form :html => { :multipart => true } do |f|
    f.inputs "Country" do
      f.input :name
      f.input :iso
      f.input :default
      f.input :default_time_zone, :as => :time_zone
    end
    f.actions
  end

end
