class ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal, only: [:index, :new, :create]
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    if params[:goal_id]
      @resources = @goal.resources.includes(:tags).ordered
      @resources = @resources.by_type(params[:type]) if params[:type].present?
      @resources = @resources.with_tags(params[:tag_ids]) if params[:tag_ids].present?
    else
      redirect_to resources_manage_path
    end
  end

  def all
    @resources = current_user.resources.includes(:goal, :tags).ordered
    @resources = @resources.by_type(params[:type]) if params[:type].present?
    @resources = @resources.with_tags(params[:tag_ids]) if params[:tag_ids].present?
    @resource_types = Resource.resource_types.keys
    @tags = current_user.tags
  end

  def show
  end

  def new
    @resource = @goal.resources.build
  end

  def edit
  end

  def create
    @resource = @goal.resources.build(resource_params)
    @resource.user = current_user

    if @resource.save
      redirect_to goal_resources_path(@goal), notice: 'Resource was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @resource.update(resource_params)
      redirect_to resources_manage_path, notice: 'Resource was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy
    redirect_to resources_manage_path, notice: 'Resource was successfully deleted.'
  end

  private

  def set_goal
    return unless params[:goal_id]
    @goal = Goal.joins(study_area: :user)
                .where(study_areas: { user_id: current_user.id })
                .find(params[:goal_id])
    @study_area = @goal.study_area
  end

  def set_resource
    @resource = Resource.joins(goal: { study_area: :user })
                       .where(goals: { study_areas: { user_id: current_user.id }})
                       .find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:title, :description, :resource_type, :url, :tag_list)
  end
end
