class CartItem
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :course_id, type: String
  field :course_title, type: String
  field :course_description, type: String
  field :course_price, type: Float, default: 0.0
  field :course_image_url, type: String

  belongs_to :cart

  scope :by_course_id, -> id {where(course_id: id)}
end
