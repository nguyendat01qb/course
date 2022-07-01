class CoursePhoto
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :course_id, type: Integer
  field :my_blog_id, type: Integer
  
  belongs_to :course
  belongs_to :my_blog
  
  mount_uploader :course_images, CoursesUploader
end
