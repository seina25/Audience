require 'test_helper'

class Admins::ProgramsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admins_programs_new_url
    assert_response :success
  end

  test "should get index" do
    get admins_programs_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_programs_show_url
    assert_response :success
  end

  test "should get edit" do
    get admins_programs_edit_url
    assert_response :success
  end

end
