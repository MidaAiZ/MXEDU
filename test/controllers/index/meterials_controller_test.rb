require 'test_helper'

class Index::MeterialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_meterial = index_meterials(:one)
  end

  test "should get index" do
    get index_meterials_url
    assert_response :success
  end

  test "should get new" do
    get new_index_meterial_url
    assert_response :success
  end

  test "should create index_meterial" do
    assert_difference('Index::Meterial.count') do
      post index_meterials_url, params: { index_meterial: { cate: @index_meterial.cate, info: @index_meterial.info, name: @index_meterial.name, tag: @index_meterial.tag } }
    end

    assert_redirected_to index_meterial_url(Index::Meterial.last)
  end

  test "should show index_meterial" do
    get index_meterial_url(@index_meterial)
    assert_response :success
  end

  test "should get edit" do
    get edit_index_meterial_url(@index_meterial)
    assert_response :success
  end

  test "should update index_meterial" do
    patch index_meterial_url(@index_meterial), params: { index_meterial: { cate: @index_meterial.cate, info: @index_meterial.info, name: @index_meterial.name, tag: @index_meterial.tag } }
    assert_redirected_to index_meterial_url(@index_meterial)
  end

  test "should destroy index_meterial" do
    assert_difference('Index::Meterial.count', -1) do
      delete index_meterial_url(@index_meterial)
    end

    assert_redirected_to index_meterials_url
  end
end
