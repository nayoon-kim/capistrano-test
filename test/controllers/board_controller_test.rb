require 'test_helper'

class BoardControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get board_create_url
    assert_response :success
  end

  test "should get list" do
    get board_list_url
    assert_response :success
  end

end
