require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(password: "foobar", password_confirmation: "foobar", role: :user, first_name: "Example", last_name: "User", email: "user@example.com", password_digest: "hmmmha10101")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
end