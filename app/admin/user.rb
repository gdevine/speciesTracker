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


index do
  column :id
  column :firstname
  column :surname
  column :email
  column :approved
  column :role
  actions
end


form do |f|
  f.inputs "Details" do
    f.input :firstname             
    f.input :surname               
    f.input :email    
    f.input :approved 
    f.collection_select :role, User::roles, :to_s, :humanize
  end
  f.actions
end
  
 permit_params :firstname, 
               :surname, 
               :email,      
               :approved,
               :role

end
