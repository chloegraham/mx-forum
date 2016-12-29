require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(role:1, first_name: "Example", last_name: "User", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end
end