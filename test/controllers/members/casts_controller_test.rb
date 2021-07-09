require 'test_helper'

class Members::CastsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get members_casts_show_url
    assert_response :success
  end

end
