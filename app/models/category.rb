class Category
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :title, type: String
  field :slug, type: String

  validates :title, :slug, presence: true

  has_many :child_categories, class_name: 'Category', dependent: :destroy, foreign_key: :category_id
  belongs_to :parent_category, class_name: 'Category', optional: true, foreign_key: :category_id

  has_many :courses, dependent: :destroy

  before_create :make_slug

  private

  def make_slug
    self.slug = title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end
end