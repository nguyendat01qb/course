class Api::V1::ReviewsController < Api::V1::BaseController
  def index
    course_id = params[:course_id]
    if(course_id)
      render json: error_message("This course does not exist")
    else
      course = Course.find(course_id)
      course_reviews = course.reviews
      render json: success_message("Sccessfilly", serializers(course_reviews, ReviewSerializer))
    end
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
    if check
      render json: success_message(message, serializer)
    else
      render json: error_message(message)
    end
  end
end
