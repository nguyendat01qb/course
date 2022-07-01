class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :course_title, :course_description, :course_price, :created_at
end
