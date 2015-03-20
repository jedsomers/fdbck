require 'test_helper'

class UsersCreateuserTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid createuser information" do
    get createuser_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "", email: "user@invalid", answer1: "", answer2: "" }
    end
    assert_template 'users/new'
  end
  
  test "valid createuser information" do
    get createuser_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Example User", email: "user@example.com", answer1: "answer", answer2: "answer2"}
    end
    assert_template 'users/show'
  end
  
end
