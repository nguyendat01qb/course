class CartsController < ApplicationController
  def index
    cart = current_user.carts.first || ''
    if cart.present?
      list_cart_item = cart.cart_items.all.to_a
      count = cart.total
    end
    @data_cart = {
      cart: cart,
      list_cart_item: list_cart_item,
      count: count
    }
  end
end
