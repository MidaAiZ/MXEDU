require 'test_helper'

class Manage::ProductCatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_product_cate = manage_product_cates(:one)
  end

  test "should get index" do
    get manage_product_cates_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_product_cate_url
    assert_response :success
  end

  test "should create manage_product_cate" do
    assert_difference('Manage::ProductCate.count') do
      post manage_product_cates_url, params: { manage_product_cate: { count: @manage_product_cate.count, name: @manage_product_cate.name } }
    end

    assert_redirected_to manage_product_cate_url(Manage::ProductCate.last)
  end

  test "should show manage_product_cate" do
    get manage_product_cate_url(@manage_product_cate)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_product_cate_url(@manage_product_cate)
    assert_response :success
  end

  test "should update manage_product_cate" do
    patch manage_product_cate_url(@manage_product_cate), params: { manage_product_cate: { count: @manage_product_cate.count, name: @manage_product_cate.name } }
    assert_redirected_to manage_product_cate_url(@manage_product_cate)
  end

  test "should destroy manage_product_cate" do
    assert_difference('Manage::ProductCate.count', -1) do
      delete manage_product_cate_url(@manage_product_cate)
    end

    assert_redirected_to manage_product_cates_url
  end
end
