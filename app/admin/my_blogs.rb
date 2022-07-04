ActiveAdmin.register MyBlog do
  permit_params :_id, :slug, :title, :subTitle, :description, :blogquote, :descDetails  
end
