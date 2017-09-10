require 'test_helper'

class Index::MaterialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_material = index_materials(:one)
  end

  test "should get index" do
    get index_materials_url
    assert_response :success
  end

  test "should get new" do
    get new_index_material_url
    assert_response :success
  end

  test "should create index_material" do
    assert_difference('Index::Material.count') do
      post index_materials_url, params: { index_material: { cate: @index_material.cate, info: @index_material.info, name: @index_material.name, tag: @index_material.tag } }
    end

    assert_redirected_to index_material_url(Index::Material.last)
  end

  test "should show index_material" do
    get index_material_url(@index_material)
    assert_response :success
  end

  test "should get edit" do
    get edit_index_material_url(@index_material)
    assert_response :success
  end

  test "should update index_material" do
    patch index_material_url(@index_material), params: { index_material: { cate: @index_material.cate, info: @index_material.info, name: @index_material.name, tag: @index_material.tag } }
    assert_redirected_to index_material_url(@index_material)
  end

  test "should destroy index_material" do
    assert_difference('Index::Material.count', -1) do
      delete index_material_url(@index_material)
    end

    assert_redirected_to index_materials_url
  end
end
