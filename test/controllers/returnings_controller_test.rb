require 'test_helper'

class ReturningsControllerTest < ActionController::TestCase
  setup do
    @returning = returnings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:returnings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create returning" do
    assert_difference('Returning.count') do
      post :create, returning: { returnDate: @returning.returnDate, returningComment: @returning.returningComment, sendingComment: @returning.sendingComment }
    end

    assert_redirected_to returning_path(assigns(:returning))
  end

  test "should show returning" do
    get :show, id: @returning
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @returning
    assert_response :success
  end

  test "should update returning" do
    patch :update, id: @returning, returning: { returnDate: @returning.returnDate, returningComment: @returning.returningComment, sendingComment: @returning.sendingComment }
    assert_redirected_to returning_path(assigns(:returning))
  end

  test "should destroy returning" do
    assert_difference('Returning.count', -1) do
      delete :destroy, id: @returning
    end

    assert_redirected_to returnings_path
  end
end
