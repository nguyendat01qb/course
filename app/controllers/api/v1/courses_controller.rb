class Api::V1::CoursesController < Api::V1::BaseController
  def index
    if params[:category_id].present?
      category_id = params[:category_id]
      category = Category.find_by(id: category_id)
      return render json: error_message("Couldn't find this category") unless category
      courses = Course.by_category(category.id).to_a
    elsif params[:value_search].present?
      value_search = params[:value_search]
      courses = Course.by_title(value_search).to_a
      return render json: error_message("Couldn't find this course") unless courses
    end
    render json: success_message("Successfully", serializers(courses, CourseSerializer))
  end
  
  def destroy
    course_id = params[:course_id]
    return render json: error_message("Couldn't find this course") unless course_id

    check, message, serializer = Course::Destroy.new(course_id, current_user, CourseSerializer).execute!
    return render json: error_message(message) unless check

    render json: success_message(message, serializer)
  end
end
