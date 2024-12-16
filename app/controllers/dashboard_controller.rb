class DashboardController < ApplicationController
  def index
    @study_areas = current_user.study_areas.ordered.includes(:goals)
  end
end
