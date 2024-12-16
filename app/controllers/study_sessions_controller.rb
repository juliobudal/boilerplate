class StudySessionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @study_session = current_user.study_sessions.build(study_session_params)
    @study_session.started_at = Time.current

    if @study_session.save
      render json: @study_session, status: :created
    else
      render json: @study_session.errors, status: :unprocessable_entity
    end
  end

  def index
    @study_sessions = current_user.study_sessions.includes(:goal)
                                .order(created_at: :desc)
                                .page(params[:page])
    
    @total_time = {
      today: StudySession.total_duration_for_period(:today),
      this_week: StudySession.total_duration_for_period(:this_week),
      this_month: StudySession.total_duration_for_period(:this_month)
    }
  end

  private

  def study_session_params
    params.require(:study_session).permit(:goal_id, :duration_minutes)
  end
end
