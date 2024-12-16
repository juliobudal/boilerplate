class StudyTimerComponent < ViewComponent::Base
  def initialize(goal:, duration: 25)
    @goal = goal
    @duration = duration
  end

  private

  attr_reader :goal, :duration
end
