require 'test_helper'

class Members::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get members_searches_search_url
    assert_response :success
  end

end
