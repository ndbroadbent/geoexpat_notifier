require 'test_helper'

class GeoexpatUsersControllerTest < ActionController::TestCase
  setup do
    @geoexpat_user = geoexpat_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geoexpat_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geoexpat_user" do
    assert_difference('GeoexpatUser.count') do
      post :create, :geoexpat_user => @geoexpat_user.attributes
    end

    assert_redirected_to geoexpat_user_path(assigns(:geoexpat_user))
  end

  test "should show geoexpat_user" do
    get :show, :id => @geoexpat_user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @geoexpat_user.to_param
    assert_response :success
  end

  test "should update geoexpat_user" do
    put :update, :id => @geoexpat_user.to_param, :geoexpat_user => @geoexpat_user.attributes
    assert_redirected_to geoexpat_user_path(assigns(:geoexpat_user))
  end

  test "should destroy geoexpat_user" do
    assert_difference('GeoexpatUser.count', -1) do
      delete :destroy, :id => @geoexpat_user.to_param
    end

    assert_redirected_to geoexpat_users_path
  end
end
