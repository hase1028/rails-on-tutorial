require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Example User", email:"user@example.com",
              password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name =" "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email =" "
    assert_not @user.valid?
  end

  test "name should not bee too long" do
    @user.name = "a" * 51     #51文字の"a"を@user.nameに代入
    assert_not @user.valid?
  end

  test "email should not bee too long" do
    @user.email = "a" * 244 + "@example.com"  #244文字の"a"と"@example.com"を足し合わせた文字を@user.emailに代入
    assert_not @user.valid?                 #@userが有効でなくなった（emailが255文字より多い）か確認(@userが無効なら成功、有効なら失敗)
  end

  test "email validation should reject invalid addresses" do
   invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com foo@bar..com]
   invalid_addresses.each do |invalid_address|
     @user.email = invalid_address
     assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
   end
  end

  test "email addresses should be unique" do
   duplicate_user = @user.dup
     duplicate_user.email = @user.email.upcase
   @user.save
   assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end


 test "password should have a minimum length" do
   @user.password = @user.password_confirmation = "a" * 5
   assert_not @user.valid?
 end
 
    test "authenticated? should return false for a user with nil digest" do
      assert_not @user.authenticated?('')
    end
end
