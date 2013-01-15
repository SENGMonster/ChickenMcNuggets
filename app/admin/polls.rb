ActiveAdmin.register Poll do
  form :partial => "form"

   index do
    column :title
    column :category
    column :question
    column :creator
    column :start_date
    column :exp_date
    column "Action" do |poll|
      link_to "Entfernen",  "/admin/polls/#{poll.id}", method: :delete
    end
  end
end
