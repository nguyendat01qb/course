class CartItem
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :course_title, type: String
  field :course_description, type: String
  field :course_price, type: Float, default: 0.0

  belongs_to :cart
end
