require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "",
                                         last_name: "pete",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_url, params: { user: { first_name:  "Example",
                                         last_name: "pete",
                                         email: "user@example1.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect! #breaking
    assert_template 'users/show'
  end

end
