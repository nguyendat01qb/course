class CourseSerializer < ActiveModel::Serializer
  attributes :_id, :slug, :title, :subTitle, :desc, :descDetail, :priorKnowledge, :price, :discount, :rateAvg,
             :countRate, :course_photos, :created_at, :user
end
