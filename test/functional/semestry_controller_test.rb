require 'test_helper'

class SemestryControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:semestry)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create semestr" do
    assert_difference('Semestr.count') do
      post :create, :semestr => { }
    end

    assert_redirected_to semestr_path(assigns(:semestr))
  end

  test "should show semestr" do
    get :show, :id => semestry(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => semestry(:one).id
    assert_response :success
  end

  test "should update semestr" do
    put :update, :id => semestry(:one).id, :semestr => { }
    assert_redirected_to semestr_path(assigns(:semestr))
  end

  test "should destroy semestr" do
    assert_difference('Semestr.count', -1) do
      delete :destroy, :id => semestry(:one).id
    end

    assert_redirected_to semestry_path
  end
end
