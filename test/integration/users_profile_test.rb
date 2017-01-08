require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:chloe)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', text: @user.first_name + " | Mx Forum"
    assert_select 'h1', text: @user.first_name + " " + @user.last_name
    assert_select 'h1>img.gravatar'
    assert_match @user.posts.count.to_s, response.body
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end
end
