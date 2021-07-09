require 'test_helper'

class Members::ProgramsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get members_programs_index_url
    assert_response :success
  end

  test "should get show" do
    get members_programs_show_url
    assert_response :success
  end

end
