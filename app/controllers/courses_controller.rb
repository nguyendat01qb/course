class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :set_category

  def index
    courses = Course.all.to_a
    list_categories = []
    Category.all.to_a.each do |category|
      next if category.child_categories.present?
      list_categories << {:key => category.id, :value => category.title }
    end

    @courses_data = {
      courses: courses,
      count: courses.count,
      list_categories: list_categories
    }
  end

  def show; end

  def new
    @course = Course.new
  end

  def edit; end

  def create
    def course(course)
      if course.save
        params[:course_photos]['course_images'].each do |a|
          @course_photos = course.course_photos.create!(course_images: a)
        end
        flash[:success] = 'Course was successfully created.'
        redirect_to course_url(course)
      else
        flash[:error] = 'Course creation failed'
      end
    end
    if current_user.is_author
      @course = current_user.courses.new(course_params)
      course(@course)
    else
      flash[:warning] = 'You can\'t create this course'
      redirect_to my_courses_path
    end
  end

  def update
    if @course.update(course_params)
      flash[:success] = 'Course was successfully updated.'
      redirect_to course_url(@course)
    else
      flash[:error] = @course.errors
      render :edit
    end
  end
  
  private
  
  def set_category
    @category = @home_categories = Category.all.to_a
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:category_id, :title, :subTitle, :desc, :descDetail, :priorKnowledge, :des_list, :price, :discount, :rateAvg,
                                   :countRate, :course_images)
  end
end
