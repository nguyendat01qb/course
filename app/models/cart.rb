class Cart
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :total, type: Integer, default: 0
  field :total_price, type: Float, default: 0.0

  has_many :cart_items, dependent: :destroy
end
