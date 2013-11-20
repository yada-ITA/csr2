require 'test_helper'

class RepairordersControllerTest < ActionController::TestCase
  setup do
    @repairorder = repairorders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repairorders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repairorder" do
    assert_difference('Repairorder.count') do
      post :create, repairorder: { constructionNo: @repairorder.constructionNo, issueDate: @repairorder.issueDate, issueNo: @repairorder.issueNo, orderNo: @repairorder.orderNo, otherBrandPartsArrivealDate: @repairorder.otherBrandPartsArrivealDate, returnDate: @repairorder.returnDate, returningComment: @repairorder.returningComment, sendingComment: @repairorder.sendingComment }
    end

    assert_redirected_to repairorder_path(assigns(:repairorder))
  end

  test "should show repairorder" do
    get :show, id: @repairorder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repairorder
    assert_response :success
  end

  test "should update repairorder" do
    patch :update, id: @repairorder, repairorder: { constructionNo: @repairorder.constructionNo, issueDate: @repairorder.issueDate, issueNo: @repairorder.issueNo, orderNo: @repairorder.orderNo, otherBrandPartsArrivealDate: @repairorder.otherBrandPartsArrivealDate, returnDate: @repairorder.returnDate, returningComment: @repairorder.returningComment, sendingComment: @repairorder.sendingComment }
    assert_redirected_to repairorder_path(assigns(:repairorder))
  end

  test "should destroy repairorder" do
    assert_difference('Repairorder.count', -1) do
      delete :destroy, id: @repairorder
    end

    assert_redirected_to repairorders_path
  end
end
