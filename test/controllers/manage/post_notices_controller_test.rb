require 'test_helper'

class Manage::PostNoticesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manage_post_notice = manage_post_notices(:one)
  end

  test "should get index" do
    get manage_post_notices_url
    assert_response :success
  end

  test "should get new" do
    get new_manage_post_notice_url
    assert_response :success
  end

  test "should create manage_post_notice" do
    assert_difference('Manage::PostNotice.count') do
      post manage_post_notices_url, params: { manage_post_notice: { cate: @manage_post_notice.cate, content: @manage_post_notice.content, name: @manage_post_notice.name } }
    end

    assert_redirected_to manage_post_notice_url(Manage::PostNotice.last)
  end

  test "should show manage_post_notice" do
    get manage_post_notice_url(@manage_post_notice)
    assert_response :success
  end

  test "should get edit" do
    get edit_manage_post_notice_url(@manage_post_notice)
    assert_response :success
  end

  test "should update manage_post_notice" do
    patch manage_post_notice_url(@manage_post_notice), params: { manage_post_notice: { cate: @manage_post_notice.cate, content: @manage_post_notice.content, name: @manage_post_notice.name } }
    assert_redirected_to manage_post_notice_url(@manage_post_notice)
  end

  test "should destroy manage_post_notice" do
    assert_difference('Manage::PostNotice.count', -1) do
      delete manage_post_notice_url(@manage_post_notice)
    end

    assert_redirected_to manage_post_notices_url
  end
end
