class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  ## Database authenticatable
  field :first_name, type: String, default: ""
  field :last_name, type: String, default: ""
  field :email, type: String, default: ""
  field :phone, type: String, default: ""
  field :is_admin, type: Boolean, default: false
  field :is_author, type: Boolean, default: false
  field :encrypted_password, type: String, default: ""
  field :api_token_digest, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  # Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String

  has_many :courses, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :reviews, dependent: :destroy

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def generate_token
    api_token = User.new_token
    update_attribute(:api_token_digest, api_token)
    api_token
  end

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end

  mount_uploader :profile_photo, ProfilePhotoUploader
end
