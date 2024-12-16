require "test_helper"

class StudyAreasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get study_areas_index_url
    assert_response :success
  end

  test "should get show" do
    get study_areas_show_url
    assert_response :success
  end

  test "should get new" do
    get study_areas_new_url
    assert_response :success
  end

  test "should get edit" do
    get study_areas_edit_url
    assert_response :success
  end
end
