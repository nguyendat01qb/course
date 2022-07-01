ActiveAdmin.register User do
  permit_params :_id, :first_name, :last_name, :email, :phone, :encrypted_password, :is_admin, :is_author, :profile_photo

  index do
    selectable_column
    id_column
    column :images do |user|
      image_tag user.profile_photo_url, size: '50x50'
    end
    column :is_admin
    column :is_author
    column :first_name
    column :last_name
    column :phone
    column :email
    actions
  end

  filter :email

  show do |_user|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone
      row :is_admin
      row :is_author
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :confirmation_sent_at
      row :confirmed_at
      row :confirmation_token
      row :unconfirmed_email
      row :images do
        image_tag user.profile_photo_url, size: '200x200'
      end
      row :jti
    end
  end

  form do |f|
    f.inputs do
      f.input :is_admin, as: :boolean
      f.input :is_author, as: :boolean
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :email
      f.input :profile_photo
    end
    f.actions
  end
end
