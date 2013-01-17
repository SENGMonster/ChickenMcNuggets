ActiveAdmin.register Creator do

  index do
    column :firstname
    column :lastname
    column :email
    column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    column :created_at
    column :updated_at
    column "Action" do |creator|
      link_to "Entfernen",  "/admin/creators/#{creator.id}", method: :delete
    end
  end
  
end
