class StaticPagesController < ApplicationController
  def home
    @categories = Category.all
  end

  def users
    @users = User.all
  end
end
