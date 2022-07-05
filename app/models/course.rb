class Course
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :slug, type: String
  field :title, type: String
  field :subTitle, type: String
  field :desc, type: String
  field :descDetail, type: Array, default: []
  field :priorKnowledge, type: String
  field :price, type: Float
  field :discount, type: Float
  field :rateAvg, type: Float, default: 0.0
  field :countRate, type: Integer, default: 0

  validates :title, presence: true, :length => { :minimum => 10, :allow_blank => false }
  validates :subTitle, presence: true, :length => { :minimum => 10, :allow_blank => false }
  validates :desc, presence: true, :length => { :minimum => 10, :allow_blank => false }
  validates :descDetail, presence: true, :length => { :minimum => 10, :allow_blank => false }
  validates :priorKnowledge, presence: true, :length => { :minimum => 5, :allow_blank => false }
  validates :price, presence: true, :length => { :minimum => 5, :allow_blank => false }
  validates :discount, presence: true, :length => { :minimum => 5, :allow_blank => false }

  has_many :course_photos, dependent: :destroy
  accepts_nested_attributes_for :course_photos, allow_destroy: true, reject_if: proc { |attributes|
                                                                                  attributes['course_photos'].blank?
                                                                                }
  belongs_to :user
  belongs_to :category
  has_many :reviews, dependent: :destroy

  # index "category.id" => 1

  scope :by_category, ->(category_id) { where(category_id: category_id) }
  scope :by_title, ->(value) { where(:title => /.*#{value}.*/) }

  def des_list=(arg)
    self.descDetail = arg.split('.').map { |v| v.strip }
  end

  def des_list
    self.descDetail.join(', ')
  end
  before_create :make_slug

  private

  def make_slug
    self.slug = title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end
end
