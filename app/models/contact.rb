class Contact
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :subject, type: String
  field :message, type: String
end
