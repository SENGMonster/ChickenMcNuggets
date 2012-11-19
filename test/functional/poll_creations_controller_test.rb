require 'test_helper'

class PollCreationsControllerTest < ActionController::TestCase
  setup do
    @poll_creation = poll_creations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poll_creations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poll_creation" do
    assert_difference('PollCreation.count') do
      post :create, poll_creation: { category_id: @poll_creation.category_id, chart_type: @poll_creation.chart_type, exp_date: @poll_creation.exp_date, poll_type_id: @poll_creation.poll_type_id, question: @poll_creation.question, title: @poll_creation.title }
    end

    assert_redirected_to poll_creation_path(assigns(:poll_creation))
  end

  test "should show poll_creation" do
    get :show, id: @poll_creation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poll_creation
    assert_response :success
  end

  test "should update poll_creation" do
    put :update, id: @poll_creation, poll_creation: { category_id: @poll_creation.category_id, chart_type: @poll_creation.chart_type, exp_date: @poll_creation.exp_date, poll_type_id: @poll_creation.poll_type_id, question: @poll_creation.question, title: @poll_creation.title }
    assert_redirected_to poll_creation_path(assigns(:poll_creation))
  end

  test "should destroy poll_creation" do
    assert_difference('PollCreation.count', -1) do
      delete :destroy, id: @poll_creation
    end

    assert_redirected_to poll_creations_path
  end
end
