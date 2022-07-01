class MyCoursesController < ApplicationController
  def index
    if current_user.is_author
      list = current_user.courses.all.to_a
      count = list.count
    elsif current_user.orders.present?
      list = current_user.orders.first.order_items
      count = list.count
    end
    list_categories = []
    Category.all.to_a.each do |category|
      next if category.child_categories.present?
      list_categories << {:key => category.id, :value => category.title }
    end

    @my_courses_data = {
      list: list,
      count: count,
      list_categories: list_categories
    }
  end
end
