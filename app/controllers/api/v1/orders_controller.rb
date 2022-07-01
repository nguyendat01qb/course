class Api::V1::OrdersController < Api::V1::BaseController
  def create
    return render json: error_message("Error can't add to order") if params[:cart_id].blank?

    cart_id = params[:cart_id]
    check, message, serializer = Order::Create.new(cart_id, current_user, OrderSerializer).execute!

    return render json: error_message(message) unless check

    render json: success_message(message, serializer)
  end
end
