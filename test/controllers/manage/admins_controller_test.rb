require 'test_helper'

class Manage::AdminsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_admin = manage_admins(:one)
  end

  test "should get index" do
    get manage_admins_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_admin_url
    assert_response :success
  end

  test "should create manage_admin" do
    assert_difference('Manage::Admin.count') do
      post manage_admins_url, params: { manage_admin: { name: @manage_admin.name, number: @manage_admin.number, password_digest: @manage_admin.password_digest, role: @manage_admin.role } }
    end

    assert_redirected_to manage_admin_url(Manage::Admin.last)
  end

  test "should show manage_admin" do
    get manage_admin_url(@manage_admin)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_admin_url(@manage_admin)
    assert_response :success
  end

  test "should update manage_admin" do
    patch manage_admin_url(@manage_admin), params: { manage_admin: { name: @manage_admin.name, number: @manage_admin.number, password_digest: @manage_admin.password_digest, role: @manage_admin.role } }
    assert_redirected_to manage_admin_url(@manage_admin)
  end

  test "should destroy manage_admin" do
    assert_difference('Manage::Admin.count', -1) do
      delete manage_admin_url(@manage_admin)
    end

    assert_redirected_to manage_admins_url
  end
end
