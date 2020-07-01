require 'test_helper'

class ReportsheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reportsheet = reportsheets(:one)
  end

  test "should get index" do
    get reportsheets_url
    assert_response :success
  end

  test "should get new" do
    get new_reportsheet_url
    assert_response :success
  end

  test "should create reportsheet" do
    assert_difference('Reportsheet.count') do
      post reportsheets_url, params: { reportsheet: { comment: @reportsheet.comment, user_id: @reportsheet.user_id } }
    end

    assert_redirected_to reportsheet_url(Reportsheet.last)
  end

  test "should show reportsheet" do
    get reportsheet_url(@reportsheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_reportsheet_url(@reportsheet)
    assert_response :success
  end

  test "should update reportsheet" do
    patch reportsheet_url(@reportsheet), params: { reportsheet: { comment: @reportsheet.comment, user_id: @reportsheet.user_id } }
    assert_redirected_to reportsheet_url(@reportsheet)
  end

  test "should destroy reportsheet" do
    assert_difference('Reportsheet.count', -1) do
      delete reportsheet_url(@reportsheet)
    end

    assert_redirected_to reportsheets_url
  end
end
