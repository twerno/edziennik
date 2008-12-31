require 'test_helper'

class GodzinyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:godziny)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create godzina" do
    assert_difference('Godzina.count') do
      post :create, :godzina => { }
    end

    assert_redirected_to godzina_path(assigns(:godzina))
  end

  test "should show godzina" do
    get :show, :id => godziny(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => godziny(:one).id
    assert_response :success
  end

  test "should update godzina" do
    put :update, :id => godziny(:one).id, :godzina => { }
    assert_redirected_to godzina_path(assigns(:godzina))
  end

  test "should destroy godzina" do
    assert_difference('Godzina.count', -1) do
      delete :destroy, :id => godziny(:one).id
    end

    assert_redirected_to godziny_path
  end
end
