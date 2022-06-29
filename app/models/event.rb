class Event
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :title, type: String
  field :description, type: String
  field :description, type: String
  field :start_time, type: Time
  field :end_time, type: Time
  field :address, type: String
  # field :learning_objectives, type: Array
  field :total_slot, type: Integer
  field :booked_slot, type: Integer
  field :cost, type: Integer

  belongs_to :user

  before_create :make_slug

  private

  def make_slug
    self.slug = title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end
end
