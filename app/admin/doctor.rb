ActiveAdmin.register Doctor do

  permit_params :id, :firstname, :lastname, :address, :address2, :zipcode, :locality, :country_id, :email, :phone, :fax, :mobile, :created_at, :updated_at
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

  form do |f|
    f.inputs "Address" do
      f.input :firstname
      f.input :lastname
      f.input :address
      f.input :address2
      f.input :zipcode
      f.input :locality
      f.input :country_id, :label => 'Country', :as => :select, :include_blank => false, :collection => Country.all.order('name')
    end
    f.inputs "Contact" do
      f.input :email
      f.input :phone
      f.input :fax
      f.input :mobile
    end
    f.actions
  end

end
