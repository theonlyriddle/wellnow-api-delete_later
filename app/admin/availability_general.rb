ActiveAdmin.register AvailabilityGeneral do
  permit_params :id, :doctor_id, :day, :hour_from, :hour_to, :created_at, :updated_at

  filter :doctor
  filter :day, :as => :select, :collection => proc { {"Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6, "Sunday" => 0} }
  filter :created_at, :as => :date_range
  filter :updated_at, :as => :date_range


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
    column :id
    column "Doctor" do |availability_general|
      availability_general.doctor.full_name
    end
    column "Day" do |availability_general|
      availability_general.day_name
    end
    column "From" do |availability_general|
      availability_general.hour_from_formatted
    end
    column "To" do |availability_general|
      availability_general.hour_to_formatted
    end
    column :created_at
    column :updated_at
    actions
  end

  form :html => { :multipart => true } do |f|
    f.inputs "Informations" do
      f.input :doctor_id, :label => 'Country', :as => :select, :include_blank => false, :collection => Doctor.all.order('firstname')
      f.input :day,  :as => :select, :include_blank => false, :collection => {"Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6, "Sunday" => 7}
      f.input :hour_from, :as => :time_select
      f.input :hour_to, :as => :time_select
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :doctor do
        availability_general.doctor
      end
      row :day do
          availability_general.day_name
      end
      row :hour_from do
          availability_general.hour_from_formatted
      end
      row :hour_to do
          availability_general.hour_to_formatted
      end
    end 
  end

end
