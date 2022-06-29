class CoursePhoto
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :course_id, type: Integer
  
  belongs_to :course
  
  mount_uploader :course_images, CoursesUploader
end
