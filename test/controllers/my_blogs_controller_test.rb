require "test_helper"

class MyBlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_blog = my_blogs(:one)
  end

  test "should get index" do
    get my_blogs_url
    assert_response :success
  end

  test "should get new" do
    get new_my_blog_url
    assert_response :success
  end

  test "should create my_blog" do
    assert_difference('MyBlog.count') do
      post my_blogs_url, params: { my_blog: { blogquote: @my_blog.blogquote, descDetails: @my_blog.descDetails, description: @my_blog.description, subTitle: @my_blog.subTitle, title: @my_blog.title } }
    end

    assert_redirected_to my_blog_url(MyBlog.last)
  end

  test "should show my_blog" do
    get my_blog_url(@my_blog)
    assert_response :success
  end

  test "should get edit" do
    get edit_my_blog_url(@my_blog)
    assert_response :success
  end

  test "should update my_blog" do
    patch my_blog_url(@my_blog), params: { my_blog: { blogquote: @my_blog.blogquote, descDetails: @my_blog.descDetails, description: @my_blog.description, subTitle: @my_blog.subTitle, title: @my_blog.title } }
    assert_redirected_to my_blog_url(@my_blog)
  end

  test "should destroy my_blog" do
    assert_difference('MyBlog.count', -1) do
      delete my_blog_url(@my_blog)
    end

    assert_redirected_to my_blogs_url
  end
end
