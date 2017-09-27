require 'test_helper'

class Index::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @index_post = index_posts(:one)
  end

  test "should get index" do
    get index_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_index_post_url
    assert_response :success
  end

  test "should create index_post" do
    assert_difference('Index::Post.count') do
      post index_posts_url, params: { index_post: { comments_count: @index_post.comments_count, content: @index_post.content, name: @index_post.name, readtimes: @index_post.readtimes, thumbs_count: @index_post.thumbs_count } }
    end

    assert_redirected_to index_post_url(Index::Post.last)
  end

  test "should show index_post" do
    get index_post_url(@index_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_index_post_url(@index_post)
    assert_response :success
  end

  test "should update index_post" do
    patch index_post_url(@index_post), params: { index_post: { comments_count: @index_post.comments_count, content: @index_post.content, name: @index_post.name, readtimes: @index_post.readtimes, thumbs_count: @index_post.thumbs_count } }
    assert_redirected_to index_post_url(@index_post)
  end

  test "should destroy index_post" do
    assert_difference('Index::Post.count', -1) do
      delete index_post_url(@index_post)
    end

    assert_redirected_to index_posts_url
  end
end
