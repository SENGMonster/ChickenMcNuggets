require 'test_helper'

class PollControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get vote" do
    get :vote
    assert_response :success
  end

end
