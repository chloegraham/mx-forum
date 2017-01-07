require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:chloe)
  end

   test "successful edit" do
   	log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    @first_name  = "Foo"
    @email = "foo@bar.com"
    patch user_path(@user), params: { user: { first_name:  @first_name,
                                              email: @email,
                                              password:              "password",
                                              password_confirmation: "password" } }
    assert_redirected_to @user
    @user.reload
    assert_equal @first_name,  @user.first_name
    assert_equal @email, @user.email
  end	 

  test "unsuccessful edit" do
  	log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end
end