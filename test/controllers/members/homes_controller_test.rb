require 'test_helper'

class Members::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get members_homes_top_url
    assert_response :success
  end

  test "should get about" do
    get members_homes_about_url
    assert_response :success
  end

end
