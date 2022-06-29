json.extract! course, :id, :title, :subTitle, :desc, :descDetail, :price, :discount, :rateAvg, :countRate, :created_at, :updated_at
json.url course_url(course, format: :json)
