class Order::Create < ServiceBase
  def initialize(cart_id, current_user, order_serializer)
    @cart_id = cart_id
    @current_user = current_user
    @order_serializer = order_serializer
  end

  def execute!
    if current_user.orders.blank?
      current_user.orders.build(first_name: current_user.first_name,
                                last_name: current_user.last_name,
                                phone: current_user.phone,
                                email: current_user.email, total: 0, total_price: 0).save
    end
    
    order = current_user.orders.first
    return [false, order.errors.full_messages.first] unless order

    cart = Cart.find(cart_id) || ''
    cart_items = cart.cart_items || ''
    return [false, 'The course is already in your cart'] if cart_items.blank?

    total = 0
    total_price = 0.0

    cart_items.each do |item|
      order_item = order.order_items.create!(course_id: item.course_id, course_title: item.course_title,
                                             course_price: item.course_price, course_image_url: item.course_image_url,
                                             author_firstname: item.author_firstname, author_lastname: item.author_lastname,
                                             rateAvg: item.rateAvg, countRate: item.countRate)
      total_price += item.course_price
      total += 1
    end

    order.total_price = total_price
    order.total = total

    if order.save && cart.destroy
      [true, 'Add to Order Successfully', ActiveModelSerializers::SerializableResource.new(order,
                                                                                           each_serializer: order_serializer)]
    else
      [false, 'Can\'t add to order']
    end
  end

  private

  attr_accessor :cart_id, :current_user, :order_serializer
end
