require 'test_helper'

class Index::AppointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_appoint = index_appoints(:one)
  end

  test "should get index" do
    get index_appoints_url
    assert_response :success
  end

  test "should get new" do
    get new_index_appoint_url
    assert_response :success
  end

  test "should create index_appoint" do
    assert_difference('Index::Appoint.count') do
      post index_appoints_url, params: { index_appoint: { content: @index_appoint.content, name: @index_appoint.name, phone: @index_appoint.phone, time: @index_appoint.time } }
    end

    assert_redirected_to index_appoint_url(Index::Appoint.last)
  end

  test "should show index_appoint" do
    get index_appoint_url(@index_appoint)
    assert_response :success
  end

  test "should get edit" do
    get edit_index_appoint_url(@index_appoint)
    assert_response :success
  end

  test "should update index_appoint" do
    patch index_appoint_url(@index_appoint), params: { index_appoint: { content: @index_appoint.content, name: @index_appoint.name, phone: @index_appoint.phone, time: @index_appoint.time } }
    assert_redirected_to index_appoint_url(@index_appoint)
  end

  test "should destroy index_appoint" do
    assert_difference('Index::Appoint.count', -1) do
      delete index_appoint_url(@index_appoint)
    end

    assert_redirected_to index_appoints_url
  end
end
