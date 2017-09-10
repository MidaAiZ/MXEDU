require 'test_helper'

class Manage::MaterialCatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_material_cate = manage_material_cates(:one)
  end

  test "should get index" do
    get manage_material_cates_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_material_cate_url
    assert_response :success
  end

  test "should create manage_material_cate" do
    assert_difference('Manage::MaterialCate.count') do
      post manage_material_cates_url, params: { manage_material_cate: { count: @manage_material_cate.count, name: @manage_material_cate.name } }
    end

    assert_redirected_to manage_material_cate_url(Manage::MaterialCate.last)
  end

  test "should show manage_material_cate" do
    get manage_material_cate_url(@manage_material_cate)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_material_cate_url(@manage_material_cate)
    assert_response :success
  end

  test "should update manage_material_cate" do
    patch manage_material_cate_url(@manage_material_cate), params: { manage_material_cate: { count: @manage_material_cate.count, name: @manage_material_cate.name } }
    assert_redirected_to manage_material_cate_url(@manage_material_cate)
  end

  test "should destroy manage_material_cate" do
    assert_difference('Manage::MaterialCate.count', -1) do
      delete manage_material_cate_url(@manage_material_cate)
    end

    assert_redirected_to manage_material_cates_url
  end
end
