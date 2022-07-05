class Cart::Create < ServiceBase
  def initialize(course_id, current_user, cart_serializer)
    @course_id = course_id
    @current_user = current_user
    @cart_serializer = cart_serializer
  end

  def execute!
    if current_user.carts.blank?
      current_user.carts.build(first_name: current_user.first_name,
                               last_name: current_user.last_name,
                               phone: current_user.phone,
                               email: current_user.email, total: 0, total_price: 0).save
    end
    cart = current_user.carts.first

    if cart
      return [false, 'The course is already in your cart'] if cart.cart_items.by_course_id(course_id).present?

      if current_user.orders.present? && current_user.orders.first.order_items.by_course_id(course_id).present?
        return [false,
                'The course is already in your order']
      end

      course = Course.find(course_id)
      course_image = Course.find(course_id).course_photos[0].course_images_url if course.course_photos.present?
      cart_item = cart.cart_items.create!(course_id: course.id, course_title: course.title, course_description: course.desc,
                                          course_price: course.discount, course_image_url: course_image)

      total = 0
      total_price = 0.0
      cart.cart_items.each do |item|
        total_price += item.course_price
        total += 1
      end
      cart.total_price = total_price
      cart.total = total

      if cart_item && cart.save
        [true, 'Add Item to Cart Successfully', ActiveModelSerializers::SerializableResource.new(cart,
                                                                                                 each_serializer: cart_serializer)]
      else
        [false, 'Can\'t add to cart']
      end
    else
      [false, cart.errors.full_messages.first]
    end
  end

  private

  attr_accessor :course_id, :current_user, :cart_serializer
end
