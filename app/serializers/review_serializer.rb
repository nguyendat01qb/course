class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rate, :comment, :child_reviews, :parent_review, :review_id, :user, :course, :created_at
end
