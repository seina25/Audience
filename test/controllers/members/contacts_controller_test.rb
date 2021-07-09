require 'test_helper'

class Members::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get members_contacts_new_url
    assert_response :success
  end

  test "should get confirm" do
    get members_contacts_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get members_contacts_thanks_url
    assert_response :success
  end

  test "should get index" do
    get members_contacts_index_url
    assert_response :success
  end

end
