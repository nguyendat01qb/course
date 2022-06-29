ActiveAdmin.register Course do
  permit_params :user_id, :category_id, :slug, :title, :subTitle, :desc, :descDetail, :price, :discount, :course_photos, :rateAvg, :countRate, :created_at, :des_list

  index do
    selectable_column
    id_column
    column :user
    column :category
    column :slug
    column :title
    column :subTitle
    column :course_images do |course|
      image_tag(course.course_photos[0].course_images_url, width: 50, height: 50) if course.course_photos.present?
    end
    column :price
    column :discount
    column :created_at
    actions
  end

  show do |_course|
    attributes_table do
      row :user
      row :category
      row :slug
      row :title
      row :subTitle
      row :images do
        columns do
          course.course_photos.each do |img|
            column do
              image_tag img.course_images_url, size: '200x200' if img.course_images_url.present?
            end
          end
        end
      end
      row :desc
      row :descDetail
      row :price
      row :discount
      row :rateAvg
      row :countRate
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :category
      f.input :title
      f.input :subTitle
      f.input :desc
      f.input :des_list
      f.input :price
      f.input :discount
    end
    f.actions
  end  
end
