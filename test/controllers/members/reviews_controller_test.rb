require 'test_helper'

class Members::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get members_reviews_show_url
    assert_response :success
  end

  test 'should get edit' do
    get members_reviews_edit_url
    assert_response :success
  end
end
