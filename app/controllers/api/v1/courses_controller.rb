class Api::V1::CoursesController < Api::V1::BaseController
  def destroy
    course_id = params[:course_id]
    if course_id.present?
      check, message, serializer = Course::Destroy.new(course_id, current_user, CourseSerializer).execute!
      if check
        render json: success_message(message, serializer)
      else
        render json: error_message(message)
      end
    else
      render json: error_message("Couldn't find this course")
    end
  end
end
