require 'test_helper'

class UczniowieControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uczniowie)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uczen" do
    assert_difference('Uczen.count') do
      post :create, :uczen => { }
    end

    assert_redirected_to uczen_path(assigns(:uczen))
  end

  test "should show uczen" do
    get :show, :id => uczniowie(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => uczniowie(:one).id
    assert_response :success
  end

  test "should update uczen" do
    put :update, :id => uczniowie(:one).id, :uczen => { }
    assert_redirected_to uczen_path(assigns(:uczen))
  end

  test "should destroy uczen" do
    assert_difference('Uczen.count', -1) do
      delete :destroy, :id => uczniowie(:one).id
    end

    assert_redirected_to uczniowie_path
  end
end
