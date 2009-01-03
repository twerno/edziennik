require 'test_helper'

class LekcjeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lekcje)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lekcja" do
    assert_difference('Lekcja.count') do
      post :create, :lekcja => { }
    end

    assert_redirected_to lekcja_path(assigns(:lekcja))
  end

  test "should show lekcja" do
    get :show, :id => lekcje(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => lekcje(:one).id
    assert_response :success
  end

  test "should update lekcja" do
    put :update, :id => lekcje(:one).id, :lekcja => { }
    assert_redirected_to lekcja_path(assigns(:lekcja))
  end

  test "should destroy lekcja" do
    assert_difference('Lekcja.count', -1) do
      delete :destroy, :id => lekcje(:one).id
    end

    assert_redirected_to lekcje_path
  end
end
