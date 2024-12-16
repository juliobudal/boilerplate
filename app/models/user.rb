class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :study_areas, dependent: :destroy
  has_many :goals, through: :study_areas
  has_many :study_sessions, dependent: :destroy
  has_many :resources, dependent: :destroy
  has_many :tags, dependent: :destroy

  def total_study_time
    study_sessions.sum(:duration_minutes)
  end

  def study_sessions_this_week
    study_sessions.this_week.count
  end

  def active_goals_count
    goals.in_progress.count
  end

  def completed_goals_count
    goals.completed.count
  end
end
