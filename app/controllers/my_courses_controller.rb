class MyCoursesController < ApplicationController
  def index
    list = current_user.courses.all.to_a
    list_categories = []
    Category.all.to_a.each do |category|
      next if category.child_categories.present?
      list_categories << {:key => category.id, :value => category.title }
    end

    @my_courses_data = {
      list: list,
      count: list.count,
      list_categories: list_categories
    }
  end
end
