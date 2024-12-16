class Resource < ApplicationRecord
  belongs_to :goal
  belongs_to :user
  has_many :resource_tags, dependent: :destroy
  has_many :tags, through: :resource_tags

  validates :title, presence: true
  validates :resource_type, presence: true
  # validates :url, url: true, if: -> { resource_type == 'link' }
  
  enum :resource_type, {
    link: 'link',
    note: 'note',
    file: 'file',
    book: 'book'
  }

  scope :ordered, -> { order(created_at: :desc) }
  scope :by_type, ->(type) { where(resource_type: type) }
  scope :with_tags, ->(tag_ids) { joins(:tags).where(tags: { id: tag_ids }).distinct }

  def tag_list
    tags.pluck(:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      user.tags.where(name: name.strip).first_or_create!
    end
  end
end
