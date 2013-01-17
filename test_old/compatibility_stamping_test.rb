$:.unshift(File.dirname(__FILE__))

require 'helpers/unit_test_helper'

# Because compatibility_mode must be set before the model is read, load the models after setting the mode
Ddb::Userstamp.compatibility_mode = true
load 'test/models/comment.rb'
load 'test/models/person.rb'
load 'test/models/ping.rb'
load 'test/models/post.rb'
load 'test/models/user.rb'

class CompatibilityStampingTests < ActiveSupport::TestCase

  def setup
    Person.stamper = @delynn
  end

  def test_comment_creation_with_stamped_object
    Person.stamper = @delynn
    assert_equal @delynn.id, Person.stamper

    comment = Comment.create(:comment => "Test Comment")
    assert_equal @delynn.id, comment.created_by
    assert_equal @delynn.id, comment.updated_by
    assert_equal @delynn, comment.creator
    assert_equal @delynn, comment.updater
  end

  def test_comment_creation_with_stamped_integer
    Person.stamper = 2
    assert_equal 2, Person.stamper

    comment = Comment.create(:comment => "Test Comment - 2")
    assert_equal @nicole.id, comment.created_by
    assert_equal @nicole.id, comment.updated_by
    assert_equal @nicole, comment.creator
    assert_equal @nicole, comment.updater
  end
  
  def test_comment_updating_with_stamped_object
    Person.stamper = @nicole
    assert_equal @nicole.id, Person.stamper

    @first_comment.comment << " - Updated"
    @first_comment.save
    @first_comment.reload
    assert_equal @delynn.id, @first_comment.created_by
    assert_equal @nicole.id, @first_comment.updated_by
    assert_equal @delynn, @first_comment.creator
    assert_equal @nicole, @first_comment.updater
  end

  def test_comment_updating_with_stamped_integer
    Person.stamper = 2
    assert_equal 2, Person.stamper

    @first_comment.comment << " - Updated"
    @first_comment.save
    @first_comment.reload
    assert_equal @delynn.id, @first_comment.created_by
    assert_equal @nicole.id, @first_comment.updated_by
    assert_equal @delynn, @first_comment.creator
    assert_equal @nicole, @first_comment.updater
  end
end