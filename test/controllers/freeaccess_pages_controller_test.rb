require 'test_helper'

class FreeaccessPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Medical API"
  end

  test "should get home" do
    get freeaccess_pages_home_url
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get freeaccess_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get freeaccess_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end
end
