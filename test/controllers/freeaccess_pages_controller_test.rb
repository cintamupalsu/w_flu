require 'test_helper'

class FreeaccessPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get freeaccess_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get freeaccess_pages_help_url
    assert_response :success
  end

end
