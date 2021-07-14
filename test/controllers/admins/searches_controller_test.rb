require 'test_helper'

class Admins::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get admins_searches_search_url
    assert_response :success
  end

end
