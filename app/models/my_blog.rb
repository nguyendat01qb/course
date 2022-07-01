class MyBlog
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :slug, type: String
  field :title, type: String
  field :subTitle, type: String
  field :description, type: String
  field :blogquote, type: String
  field :descDetails, type: Array, default: []

  has_many :course_photos, dependent: :destroy
  accepts_nested_attributes_for :course_photos, allow_destroy: true, reject_if: proc { |attributes|
                                                                                  attributes['course_photos'].blank?
                                                                                }
  belongs_to :user
  def des_list=(arg)
    self.descDetails = arg.split('.').map { |v| v.strip }
  end

  def des_list
    descDetails.join(', ')
  end
  before_create :make_slug

  private

  def make_slug
    self.slug = title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end
end
