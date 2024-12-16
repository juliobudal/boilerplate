class Tag < ApplicationRecord
  belongs_to :user
  has_many :resource_tags, dependent: :destroy
  has_many :resources, through: :resource_tags

  validates :name, presence: true, uniqueness: { scope: :user_id }
  
  before_save :normalize_name

  scope :ordered, -> { order(:name) }
  scope :with_resources_count, -> { 
    select('tags.*, COUNT(resources.id) as resources_count')
    .left_joins(:resources)
    .group('tags.id')
  }

  private

  def normalize_name
    self.name = name.downcase.strip
  end
end
