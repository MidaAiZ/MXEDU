require 'test_helper'

class Index::PostCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_post_comment = index_post_comments(:one)
  end

  test "should get index" do
    get index_post_comments_url
    assert_response :success
  end

  test "should get new" do
    get new_index_post_comment_url
    assert_response :success
  end

  test "should create index_post_comment" do
    assert_difference('Index::PostComment.count') do
      post index_post_comments_url, params: { index_post_comment: { content: @index_post_comment.content } }
    end

    assert_redirected_to index_post_comment_url(Index::PostComment.last)
  end

  test "should show index_post_comment" do
    get index_post_comment_url(@index_post_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_index_post_comment_url(@index_post_comment)
    assert_response :success
  end

  test "should update index_post_comment" do
    patch index_post_comment_url(@index_post_comment), params: { index_post_comment: { content: @index_post_comment.content } }
    assert_redirected_to index_post_comment_url(@index_post_comment)
  end

  test "should destroy index_post_comment" do
    assert_difference('Index::PostComment.count', -1) do
      delete index_post_comment_url(@index_post_comment)
    end

    assert_redirected_to index_post_comments_url
  end
end
