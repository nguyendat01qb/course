class Api::V1::ReviewsController < Api::V1::BaseController
  def index
    course_id = params[:course_id]
    return render json: error_message('This course does not exist') if course_id

    course = Course.find(course_id)
    course_reviews = course.reviews
    render json: success_message('Sccessfilly', serializers(course_reviews, ReviewSerializer))
  end

  def create
    comment = params[:comment]
    course_id = params[:course_id]

    if params[:rate]
      rate = params[:rate].to_i
      check, message, serializer = Review::Create.new(rate, comment, course_id, '', current_user,
                                                      ReviewSerializer).execute!
    elsif params[:review_id]
      review_id = params[:review_id]
      check, message, serializer = Review::Create.new(0, comment, course_id, review_id,
                                                      current_user, ReviewSerializer).execute!
    end

    return render json: error_message(message) unless check

    render json: success_message(message, serializer)
  end

  def destroy
    review_id = params[:review_id]
    course_id = params[:course_id]

    review = current_user.reviews.find(review_id)
    list_reviews = Course.find(course_id).reviews
    if review.present? && review.destroy
      render json: success_message('Comment deleted successfully',
                                   serializers(list_reviews, ReviewSerializer))
    else
      render json: error_message("You can't delete this comment")
    end
  end
end
