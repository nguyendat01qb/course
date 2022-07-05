class Api::V1::CartsController < Api::V1::BaseController
  def create
    if params[:course_id].present?
      course_id = params[:course_id]
      check, message, serializer = Cart::Create.new(course_id, current_user, CartSerializer).execute!
    else
      render json: error_message("Error can't add this course to cart")
    end

    if check
      render json: success_message(message, serializer)
    else
      render json: error_message(message)
    end
  end

  def destroy
    cart_item_id = params[:cart_item_id]
    cart_item = current_user.carts.first.cart_items.find(cart_item_id) || ''
    cart = current_user.carts.first

    if cart_item&.destroy
      total = 0
      total_price = 0.0
      cart.cart_items.each do |item|
        total_price += item.course_price
        total += 1
      end
      cart.total_price = total_price
      cart.total = total
      cart.save

      render json: success_message('Cart item deleted successfully', serializers(cart, CartSerializer))
    else
      render json: error_message('Failed to delete cart item')
    end
  end
end
