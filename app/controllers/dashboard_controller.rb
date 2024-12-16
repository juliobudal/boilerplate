class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @study_areas = current_user.study_areas.includes(:goals)
    @recent_goals = current_user.goals.includes(:study_area).order(updated_at: :desc).limit(5)
    @in_progress_goals = current_user.goals.includes(:study_area).where(status: :in_progress).order(due_date: :asc)
  end
end
