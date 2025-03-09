require "test_helper"

class BoardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get board_index_url
    assert_response :success
  end
end
