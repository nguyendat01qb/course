class Course::Destroy < ServiceBase
  def initialize(course_id, current_user, course_serializer)
    @course_id = course_id
    @current_user = current_user
    @course_serializer = course_serializer
  end

  def execute!
    course_des = current_user.courses.find(course_id)
    return [false, 'You don\'t have permission to delete this course'] unless course_des

    if course_des&.destroy
      my_course = current_user.courses.all.to_a
      [true, 'Deleted Couse Successfully', ActiveModelSerializers::SerializableResource.new(my_course,
                                                                                            each_serializer: course_serializer)]
    else
      [false, 'Course destroy failed']
    end
  end

  private

  attr_accessor :course_id, :current_user, :course_serializer
end
