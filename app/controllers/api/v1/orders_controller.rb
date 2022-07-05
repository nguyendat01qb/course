class Api::V1::OrdersController < Api::V1::BaseController
  def index
    # carts = current_user.carts.by_status(User::STATUS[:pending])
    # if carts
    #   render json: success_message('Successfully', serializers(carts, CartSerializer))
    # else
    #   render json: error_message('No item in cart')
    # end
  end

  def create
    if params[:cart_id].present?
      cart_id = params[:cart_id]
      check, message, serializer = Order::Create.new(cart_id, current_user, OrderSerializer).execute!
    else
      render json: error_message("Error can't add to order")
    end

    if check
      render json: success_message(message, serializer)
    else
      render json: error_message(message)
    end
  end
end
