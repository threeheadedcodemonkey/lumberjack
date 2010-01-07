require File.dirname(__FILE__) + '/../test_helper'

class LumberJackPluginTest < ActiveSupport::TestCase
  
  test "Module should exist" do
    assert_nothing_raised do
      assert_equal Module, Lumberjack.class
    end
  end
  
  test "The observer should be registered" do
    assert_equal 1, Foo.count_observers
    assert_equal 1, Bar.count_observers
  end
  
  test "The observer should be called when creating a Foo" do 
    @user = User.create(:name => 'Joe User')
    @foo = Foo.create( :user_id => @user.id)
    @logs = UserLog.find_all_by_user_id(@user.id)
    assert_equal 1, @logs.size
    @log = @logs.first
    assert_equal 'create', @log.action
    assert_equal @user, @log.user
    assert_equal @foo, @log.loggable
  end

  test "The observer should be called when updating a Foo" do 
    @user = User.create(:name => 'Joe User')
    
    @foo = Foo.create( :user_id => @user.id)
    @foo.name = "Foo 2"
    @foo.save
    
    @logs = UserLog.find_all_by_user_id(@user.id)
    assert_equal 2, @logs.size
    @log = @logs.second
    assert_equal 'update', @log.action
    assert_equal @user, @log.user
    assert_equal @foo, @log.loggable
  end
  
  test "Humanize should return a readable version of the log in the default locale" do
    I18n.locale = 'en'
    @user = User.create(:name => 'Joe User')
    @foo = Foo.create( :user_id => @user.id)
    @log = UserLog.find_all_by_user_id(@user.id).first
    assert_equal "#{@user.name} created a Foo", @log.humanize
  end
  
  test "Humanize should return a readable version of the log localized" do
    @user = User.create(:name => 'Joe User')
    I18n.locale = 'es'
    @foo = Foo.create( :user_id => @user.id)
    @log = UserLog.find_all_by_user_id(@user.id).first
    assert_equal "#{@user.name} creó un Foo", @log.humanize
  end
  
  test "Defining a message works as expected" do
    I18n.locale = 'en'
    @user = User.create(:name => 'Joe User')
    @bar = Bar.create(:user_id => @user.id)
    @log = UserLog.find_all_by_user_id(@user.id).first
    assert_equal "Joe User is proud to announce that his new Bar has been created!", @log.humanize
  end

  test "UserLog should be removed if the logged object is removed" do
    @user = User.create(:name => 'Joe User')
    @bar = Bar.create(:user_id => @user.id)
    @log = UserLog.find_all_by_user_id(@user.id).first
    assert !UserLog.find_all_by_user_id(@user.id).empty?
    @bar.destroy
    assert UserLog.find_all_by_user_id(@user.id).empty?
    
  end
    
end
