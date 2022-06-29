ActiveAdmin.register CoursePhoto do
  permit_params :_id, :course_images, :course_id

  index do
    selectable_column
    id_column
    column :course
    column :course_images do |course|
      image_tag(course.course_images_url, width: 50, height: 50)
    end
    actions
  end

  form do |f|
    f.inputs 'Course' do
      f.input :course, as: :select, collection: Course.all
    end
    f.inputs do
      f.input :course_images, as: :file
    end
    f.actions
  end

  show do |_course|
    attributes_table do
      row :course
      row :course_images do |course|
        image_tag(course.course_images_url, width: 200, height: 200)
      end
    end
  end
end
