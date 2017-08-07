require 'test_helper'

class Index::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_user = index_users(:one)
  end

  test "should get index" do
    get index_users_url
    assert_response :success
  end

  test "should get new" do
    get new_index_user_url
    assert_response :success
  end

  test "should create index_user" do
    assert_difference('Index::User.count') do
      post index_users_url, params: { index_user: { email: @index_user.email, info: @index_user.info, name: @index_user.name, number: @index_user.number, password_digest: @index_user.password_digest, phone: @index_user.phone, sex: @index_user.sex } }
    end

    assert_redirected_to index_user_url(Index::User.last)
  end

  test "should show index_user" do
    get index_user_url(@index_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_index_user_url(@index_user)
    assert_response :success
  end

  test "should update index_user" do
    patch index_user_url(@index_user), params: { index_user: { email: @index_user.email, info: @index_user.info, name: @index_user.name, number: @index_user.number, password_digest: @index_user.password_digest, phone: @index_user.phone, sex: @index_user.sex } }
    assert_redirected_to index_user_url(@index_user)
  end

  test "should destroy index_user" do
    assert_difference('Index::User.count', -1) do
      delete index_user_url(@index_user)
    end

    assert_redirected_to index_users_url
  end
end
