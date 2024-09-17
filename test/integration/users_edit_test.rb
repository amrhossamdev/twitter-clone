require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:amr)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: "Example User",
                                              email: "user@example.com",
                                              password: "password",
                                              password_confirmation: "pa1ssword" } }
    assert_template "users/edit"
  end

  test "successful edit" do
    get edit_user_path(@user)
    name = "Example User"
    email = "user@example.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
