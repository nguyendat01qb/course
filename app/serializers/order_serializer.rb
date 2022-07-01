class OrderSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone, :email, :order_items, :user_id, :total, :total_price, :created_at
end
  