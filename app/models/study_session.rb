class StudySession < ApplicationRecord
  belongs_to :goal
  belongs_to :user

  validates :duration_minutes, presence: true, numericality: { greater_than: 0 }
  validates :started_at, presence: true

  scope :today, -> { where(created_at: Time.current.beginning_of_day..Time.current.end_of_day) }
  scope :this_week, -> { where(created_at: Time.current.beginning_of_week..Time.current.end_of_week) }
  scope :this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) }

  def self.total_duration_for_period(period)
    send(period).sum(:duration_minutes)
  end

  def completed?
    ended_at.present?
  end

  def current_duration
    if completed?
      duration_minutes
    else
      ((Time.current - started_at) / 60).to_i
    end
  end
end
