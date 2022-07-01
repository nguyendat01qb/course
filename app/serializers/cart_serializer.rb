class CartSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone, :email, :cart_items, :user_id, :total, :total_price, :created_at
end
  