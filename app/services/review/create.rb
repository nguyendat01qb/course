class Review::Create < ServiceBase
  def initialize(rate, comment, course_id, review_id, current_user, review_serializer)
    @rate = rate
    @comment = comment
    @course_id = course_id
    @review_id = review_id
    @current_user = current_user
    @review_serializer = review_serializer
  end

  def execute!
    return [false, 'You have not rated this product'] if comment.blank?
    c_review = { comment: comment, course_id: course_id }
    if rate > 0
      sum_rate = 0
      count_rate = 0
      course = Course.find(course_id)
      course.reviews.each do |rev|
        count_rate += 1
        next if (rev.rate.nil? || rev.rate == 0)
        sum_rate += rev.rate
      end
      rateAvg = (sum_rate.to_f/count_rate.to_f).round(2)
      course.update(rateAvg: rateAvg, countRate: count_rate)
      c_review.merge!(rate: rate)
    elsif review_id
      c_review.merge!(review_id: review_id)
    end
    review = current_user.reviews.build(c_review)
    if review.save
      list_reviews = Course.find(course_id).reviews
      [true, 'Commented Successfully', ActiveModelSerializers::SerializableResource.new(list_reviews,
                                                                                        each_serializer: review_serializer)]
    else
      [false, 'You have not signed in']
    end
  end

  private

  attr_accessor :rate, :comment, :course_id, :review_id, :current_user, :review_serializer
end
