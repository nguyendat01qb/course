class MyBlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :subTitle, :description, :blogquote, :descDetails, :course_photos, :user, :created_at
end
