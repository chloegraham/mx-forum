require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:chloe)
    @admin = users(:admin)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.first_name
    end
  end

  test "index as admin including delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    #assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.first_name
    end
    assert_difference 'User.count', 0 do
      delete user_path(@user)
    end
  end

  test "index as non-admin" do
    log_in_as(@user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
