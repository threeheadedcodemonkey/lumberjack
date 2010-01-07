require File.dirname(__FILE__) + '/../test_helper'

class UserLogTest < ActiveSupport::TestCase
  test "UserLog should belong to user" do
    assert UserLog.column_names.include?('user_id')
    reflection = UserLog.reflect_on_association(:user)
    assert_not_nil reflection
    assert_equal :belongs_to, reflection.macro
  end
  
  test "UserLog should belong to user polymorphic" do
    assert UserLog.column_names.include?('loggable_id')
    assert UserLog.column_names.include?('loggable_type')
    reflection = UserLog.reflect_on_association(:user)
    assert_not_nil reflection
    assert_equal :belongs_to, reflection.macro
  end

end
