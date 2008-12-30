require 'test_helper'

class NauczycieleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nauczyciele)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nauczyciel" do
    assert_difference('Nauczyciel.count') do
      post :create, :nauczyciel => { }
    end

    assert_redirected_to nauczyciel_path(assigns(:nauczyciel))
  end

  test "should show nauczyciel" do
    get :show, :id => nauczyciele(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => nauczyciele(:one).id
    assert_response :success
  end

  test "should update nauczyciel" do
    put :update, :id => nauczyciele(:one).id, :nauczyciel => { }
    assert_redirected_to nauczyciel_path(assigns(:nauczyciel))
  end

  test "should destroy nauczyciel" do
    assert_difference('Nauczyciel.count', -1) do
      delete :destroy, :id => nauczyciele(:one).id
    end

    assert_redirected_to nauczyciele_path
  end
end
