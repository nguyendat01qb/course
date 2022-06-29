ActiveAdmin.register Category do
  permit_params :category_id, :title, :slug
  
  index do
    selectable_column
    id_column
    column :parent_category
    column :title
    column :slug
    actions
  end

  form do |f|
    f.inputs do
      f.input :parent_category
      f.input :title
    end
    f.actions
  end
end
