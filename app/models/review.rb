class Review
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :comment, type: String
  field :rate, type: Integer

  has_many :child_reviews, class_name: 'Review', dependent: :destroy, foreign_key: :review_id
  belongs_to :parent_review, class_name: 'Review', optional: true, foreign_key: :review_id

  belongs_to :course
  belongs_to :user
end
