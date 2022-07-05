class CourseSerializer < ActiveModel::Serializer
  attributes :id, :slug, :title, :subTitle, :desc, :descDetail, :priorKnowledge, :price, :discount, :rateAvg,
             :countRate, :course_photos, :created_at, :user
end
