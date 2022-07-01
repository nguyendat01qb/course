class CourseDetailsController < ApplicationController
  def index
    @course_details = Course.find_by({ slug: params[:slug] })
  end
end
