class Topic
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :title, type: String

  belongs_to :user
end
