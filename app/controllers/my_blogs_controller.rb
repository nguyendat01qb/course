class MyBlogsController < InheritedResources::Base
  before_action :set_blog, only: %i[show edit update destroy]

  def index
    @my_blogs = MyBlog.all.to_a
  end

  def show; end

  def new
    @my_blog = MyBlog.new
  end

  def edit; end

  def create
    def my_blog(my_blog)
      if my_blog.save
        params[:course_photos]['course_images'].each do |a|
          @course_photos = my_blog.course_photos.create!(course_images: a)
        end
        flash[:success] = 'Blog was successfully created.'
        redirect_to my_blog_url(my_blog)
      else
        flash[:error] = 'Blog creation failed'
      end
    end
    if current_user
      @my_blog = current_user.my_blogs.new(my_blog_params)
      my_blog(@my_blog)
    else
      flash[:warning] = 'You can\'t create this course'
      redirect_to my_blogs_path
    end
  end

  def update
    if @my_blog.update(my_blog_params)
      flash[:success] = 'Blog was successfully updated.'
      redirect_to my_blog_url(@my_blog)
    else
      flash[:error] = @my_blog.errors
      render :edit
    end
  end

  private

  def set_blog
    @my_blog = MyBlog.find(params[:id])
  end

  def my_blog_params
    params.require(:my_blog).permit(:title, :subTitle, :description, :blogquote, :descDetails, :des_list, :course_images)
  end
end
