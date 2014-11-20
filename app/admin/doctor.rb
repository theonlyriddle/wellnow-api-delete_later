ActiveAdmin.register Doctor do
  filter :categories

  permit_params :id, :firstname, :lastname, :address, :address2, :zipcode, :locality, :country_id, :email, :phone, :fax, :mobile, :categories, :avatar, :avatar_cache, :background, :background_cache, :created_at, :updated_at
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

  index do
    selectable_column
    column "Avatar" do |doctor|
      image_tag(doctor.avatar_mini_url)
    end
    column :firstname
    column :lastname
    column "Email" do |doctor|
      mail_to doctor.email
    end
    column "Email" do |doctor|
      link_to doctor.phone, 'tel:' + doctor.phone
    end
    column :created_at
    column :updated_at
    actions
  end

  form :html => { :multipart => true } do |f|
    f.inputs "Address" do
      f.input :firstname
      f.input :lastname
      f.input :address
      f.input :address2
      f.input :zipcode
      f.input :locality
      f.input :country_id, :label => 'Country', :as => :select, :include_blank => true, :collection => Country.all.order('name')
    end
    f.inputs "Contact" do
      f.input :email
      f.input :phone
      f.input :fax
      f.input :mobile
    end

    f.inputs "Images" do
      f.input :avatar, :image_preview => true
      f.input :avatar_cache, :as => :hidden 
      f.input :background, :image_preview => true
      f.input :background_cache, :as => :hidden 
    end

    f.inputs "Categories" do
        f.has_many :categories, :allow_destroy => false, :heading => false, :new_record => false do |cf|
          cf.input :title
        end
    end
    f.actions
  end

  show do
    attributes_table do
      row :firstname
      row :lastname
      row :avatar do
          image_tag(doctor.avatar_mini_url)
      end
      row :background do
          image_tag(doctor.background_cropped_url)
      end
    end 
  end

end
