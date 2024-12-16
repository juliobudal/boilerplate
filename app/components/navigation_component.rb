# frozen_string_literal: true

class NavigationComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  private

  attr_reader :user
end
