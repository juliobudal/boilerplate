class Goal < ApplicationRecord
  belongs_to :study_area
  has_one :user, through: :study_area
  has_many :study_sessions, dependent: :destroy
  has_many :resources, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true

  enum :status, {
    not_started: 0,
    in_progress: 1,
    completed: 2
  }

  scope :ordered, -> { order(due_date: :asc) }
  scope :not_started, -> { where(status: 'not_started') }
  scope :in_progress, -> { where(status: 'in_progress') }
  scope :completed, -> { where(status: 'completed') }

  def completed?
    status == 'completed'
  end

  def overdue?
    !completed? && due_date < Time.current
  end

  def total_study_time
    study_sessions.sum(:duration_minutes)
  end

  def study_sessions_this_week
    study_sessions.this_week
  end

  def average_session_duration
    study_sessions.average(:duration_minutes)&.to_i || 0
  end
end
