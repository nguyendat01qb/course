class Api::V1::BlogsController < Api::V1::BaseController
  def destroy
    blog_id = params[:blog_id]
    return render json: error_message("Couldn't find this blog") if blog_id.blank?

    blog_des = current_user.my_blogs.find(blog_id)
    return [false, 'You don\'t have permission to delete this blog'] unless blog_des

    if blog_des
    # if blog_des&.destroy
      blog = MyBlog.all.to_a
      render json: success_message('Deleted Blog Successfully', serializers(blog, MyBlogSerializer))
    else

      render json: error_message('Blog destroy failed')
    end
  end
end
