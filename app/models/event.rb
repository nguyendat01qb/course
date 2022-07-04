class Event
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :start_time, type: DateTime
  field :end_time, type: DateTime
  field :address, type: String
  field :total_slot, type: Integer
  field :booked_slot, type: Integer
  field :cost, type: Integer

  belongs_to :user
  belongs_to :course

end
