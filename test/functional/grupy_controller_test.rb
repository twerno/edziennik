require 'test_helper'

class GrupyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grupy)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grupa" do
    assert_difference('Grupa.count') do
      post :create, :grupa => { }
    end

    assert_redirected_to grupa_path(assigns(:grupa))
  end

  test "should show grupa" do
    get :show, :id => grupy(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => grupy(:one).id
    assert_response :success
  end

  test "should update grupa" do
    put :update, :id => grupy(:one).id, :grupa => { }
    assert_redirected_to grupa_path(assigns(:grupa))
  end

  test "should destroy grupa" do
    assert_difference('Grupa.count', -1) do
      delete :destroy, :id => grupy(:one).id
    end

    assert_redirected_to grupy_path
  end
end
