class StudyAreasController < ApplicationController
  before_action :set_study_area, only: [:show, :edit, :update, :destroy]

  def index
    @study_areas = current_user.study_areas.ordered.includes(:goals)
  end

  def show
    @goals = @study_area.goals.ordered
  end

  def new
    @study_area = current_user.study_areas.build
  end

  def edit
  end

  def create
    @study_area = current_user.study_areas.build(study_area_params)

    if @study_area.save
      redirect_to study_areas_path, notice: 'Study area was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @study_area.update(study_area_params)
      redirect_to study_areas_path, notice: 'Study area was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @study_area.destroy
    redirect_to study_areas_path, notice: 'Study area was successfully deleted.'
  end

  private

  def set_study_area
    @study_area = current_user.study_areas.find(params[:id])
  end

  def study_area_params
    params.require(:study_area).permit(:title, :description)
  end
end
