require "test_helper"

class MyCourseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_course_index_url
    assert_response :success
  end
end
