require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    puts @user # Logs user object
    assert_difference("User.count") do
      new_user = { 
        username: "user_#{SecureRandom.hex(4)}", 
        email_address: "user_#{SecureRandom.hex(4)}@example.com", 
        password: SecureRandom.hex(8) 
      }
      post users_url, params: { user: new_user }
    end
    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { username: @user.username, email_address: @user.email_address, password: @user.password_digest } }
    assert_redirected_to user_url(@user)
  end

  test "should ban user" do
    user = users(:one)
    reason = "Violation of terms"
    assert_difference "user.bans.count", 1 do
      patch ban_user_path(user), params: { reason: reason }
      puts response.body
    end
    assert_redirected_to user_url(user)
    follow_redirect!
    assert_match "User was successfully banned.", response.body
  end

  test "should not ban user if reason is missing" do
    user = users(:one)
    assert_no_difference "user.bans.count" do
      patch ban_user_path(user), params: { reason: "" }
    end
    assert_match "Problems banning user.", response.body
  end

  test "should unban user" do
    user = users(:one)
    user.bans.create!(reason: "Violation of terms")
    assert_difference "user.bans.count", -1 do
      patch unban_user_path(user), params: { reason: "" }
    end
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_url
  end
end
