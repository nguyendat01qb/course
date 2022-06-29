require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @course = courses(:one)
  end

  test "visiting the index" do
    visit courses_url
    assert_selector "h1", text: "Courses"
  end

  test "creating a Course" do
    visit courses_url
    click_on "New Course"

    fill_in "Countrate", with: @course.countRate
    fill_in "Desc", with: @course.desc
    fill_in "Descdetail", with: @course.descDetail
    fill_in "Discount", with: @course.discount
    fill_in "Price", with: @course.price
    fill_in "Rateavg", with: @course.rateAvg
    fill_in "Subtitle", with: @course.subTitle
    fill_in "Title", with: @course.title
    click_on "Create Course"

    assert_text "Course was successfully created"
    click_on "Back"
  end

  test "updating a Course" do
    visit courses_url
    click_on "Edit", match: :first

    fill_in "Countrate", with: @course.countRate
    fill_in "Desc", with: @course.desc
    fill_in "Descdetail", with: @course.descDetail
    fill_in "Discount", with: @course.discount
    fill_in "Price", with: @course.price
    fill_in "Rateavg", with: @course.rateAvg
    fill_in "Subtitle", with: @course.subTitle
    fill_in "Title", with: @course.title
    click_on "Update Course"

    assert_text "Course was successfully updated"
    click_on "Back"
  end

  test "destroying a Course" do
    visit courses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course was successfully destroyed"
  end
end
