require 'test_helper'

class BasicPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "FDBCK"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | FDBCK"
  end

  test "should get faq" do
    get :faq
    assert_response :success
    assert_select "title", "FAQ | FDBCK"
  end

end
