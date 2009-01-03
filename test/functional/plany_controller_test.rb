require 'test_helper'

class PlanyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plany)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plan" do
    assert_difference('Plan.count') do
      post :create, :plan => { }
    end

    assert_redirected_to plan_path(assigns(:plan))
  end

  test "should show plan" do
    get :show, :id => plany(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => plany(:one).id
    assert_response :success
  end

  test "should update plan" do
    put :update, :id => plany(:one).id, :plan => { }
    assert_redirected_to plan_path(assigns(:plan))
  end

  test "should destroy plan" do
    assert_difference('Plan.count', -1) do
      delete :destroy, :id => plany(:one).id
    end

    assert_redirected_to plany_path
  end
end
