ActiveAdmin.register User do
  index do
    column :email
    column :brand
    default_actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :brand
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end

