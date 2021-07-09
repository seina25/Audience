require 'test_helper'

class Admins::CastsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admins_casts_new_url
    assert_response :success
  end

  test "should get index" do
    get admins_casts_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_casts_show_url
    assert_response :success
  end

  test "should get edit" do
    get admins_casts_edit_url
    assert_response :success
  end

end
