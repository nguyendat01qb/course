class MyBlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :subTitle, :description, :blogquote, :descDetails
end
