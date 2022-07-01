class Order
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :first_name, type: String, default: ""
  field :last_name, type: String, default: ""
  field :email, type: String, default: ""
  field :phone, type: String, default: ""
  field :total, type: Integer, default: 0
  field :total_price, type: Float, default: 0.0

  has_many :order_items, dependent: :destroy
  belongs_to :user
end
