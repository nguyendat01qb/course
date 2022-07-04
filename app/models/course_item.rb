class CourseItem
  include Mongoid::Document
  field :title, type: String
  field :description, type: String

  belongs_to :course
  belongs_to :user

  mount_uploader :video, VideoUploader
end
