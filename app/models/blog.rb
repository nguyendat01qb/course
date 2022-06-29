class Blog
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :slug, type: String
  field :title, type: String
  field :subTitle, type: String
  field :desc, type: String
  field :descDetail, type: String

  # has_many :course_photos, dependent: :destroy
  # accepts_nested_attributes_for :course_photos, allow_destroy: true, reject_if: proc { |attributes| attributes['course_photos'].blank? }
  # belongs_to :user
  # belongs_to :category

  before_create :make_slug

  private

  def make_slug
    self.slug = title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end
end
