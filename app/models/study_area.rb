class StudyArea < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
