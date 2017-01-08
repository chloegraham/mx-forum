require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @post = posts(:mx_video)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { content: @post.content, location: @post.location, title: @post.title, user_id: @post.user_id, views: @post.views } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should not show post" do
    get post_url(@post)
    assert_response :fail
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy if not your post to delete" do
    log_in_as(users(:chloe))
    post = post(:ants)
    assert_no_difference 'post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end

end
