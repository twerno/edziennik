require 'test_helper'

class PrzedmiotyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:przedmioty)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create przedmiot" do
    assert_difference('Przedmiot.count') do
      post :create, :przedmiot => { }
    end

    assert_redirected_to przedmiot_path(assigns(:przedmiot))
  end

  test "should show przedmiot" do
    get :show, :id => przedmioty(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => przedmioty(:one).id
    assert_response :success
  end

  test "should update przedmiot" do
    put :update, :id => przedmioty(:one).id, :przedmiot => { }
    assert_redirected_to przedmiot_path(assigns(:przedmiot))
  end

  test "should destroy przedmiot" do
    assert_difference('Przedmiot.count', -1) do
      delete :destroy, :id => przedmioty(:one).id
    end

    assert_redirected_to przedmioty_path
  end
end
