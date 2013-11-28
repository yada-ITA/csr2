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
      post :create, repairorder: { branchCode: @repairorder.branchCode, businessstatus_id: @repairorder.businessstatus_id, changeComment: @repairorder.changeComment, deliveryDate: @repairorder.deliveryDate, inquiryDate: @repairorder.inquiryDate, issueNo: @repairorder.issueNo, loginUserId: @repairorder.loginUserId, machineNo: @repairorder.machineNo, orderer: @repairorder.orderer, placeCode: @repairorder.placeCode, sendingComment: @repairorder.sendingComment, sendingCompanyCode: @repairorder.sendingCompanyCode, timeOfRunning: @repairorder.timeOfRunning, userId: @repairorder.userId }
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
    patch :update, id: @repairorder, repairorder: { branchCode: @repairorder.branchCode, businessstatus_id: @repairorder.businessstatus_id, changeComment: @repairorder.changeComment, deliveryDate: @repairorder.deliveryDate, inquiryDate: @repairorder.inquiryDate, issueNo: @repairorder.issueNo, loginUserId: @repairorder.loginUserId, machineNo: @repairorder.machineNo, orderer: @repairorder.orderer, placeCode: @repairorder.placeCode, sendingComment: @repairorder.sendingComment, sendingCompanyCode: @repairorder.sendingCompanyCode, timeOfRunning: @repairorder.timeOfRunning, userId: @repairorder.userId }
    assert_redirected_to repairorder_path(assigns(:repairorder))
  end

  test "should destroy repairorder" do
    assert_difference('Repairorder.count', -1) do
      delete :destroy, id: @repairorder
    end

    assert_redirected_to repairorders_path
  end
end
