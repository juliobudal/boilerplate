class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study_area, only: [:edit, :update, :new, :create, :destroy, :show]
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :update_status]

  def index
    @goals = current_user.goals.includes(:study_area).order(due_date: :asc)
    @goals_by_status = @goals.group_by(&:status)
  end

  def show
  end

  def new
    @goal = @study_area.goals.build
  end

  def edit
  end

  def create
    @goal = @study_area.goals.build(goal_params)

    if @goal.save
      redirect_to @goal, notice: 'Goal was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: 'Goal was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    study_area = @goal.study_area
    @goal.destroy
    redirect_to study_area_path(study_area), notice: 'Goal was successfully deleted.', status: :see_other
  end

  def update_status
    if @goal.update(status: params[:status])
      redirect_to @goal, notice: 'Goal status was successfully updated.'
    else
      redirect_to @goal, alert: 'Failed to update goal status.'
    end
  end

  private

  def set_study_area
    @study_area = current_user.study_areas.find(params[:study_area_id])
  end

  def set_goal
    @goal = @study_area.goals.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:title, :description, :status, :due_date)
  end
end
