require 'active_mocker/mock_requires'
Object.send(:remove_const, "MicropostMock") if ActiveMocker.class_exists?("MicropostMock")

class MicropostMock < ::ActiveHash::Base
  include ActiveMocker::ActiveHash::ARApi
  include ActiveMocker::MockInstanceMethods
  extend  ActiveMocker::MockClassMethods

  def initialize(attributes={}, &block)
    @attributes = HashWithIndifferentAccess.new({"id"=>nil, "content"=>nil, "user_id"=>nil, "up_votes"=>nil, "created_at"=>nil, "updated_at"=>nil})
    super(attributes, &block)
  end


  def self.column_names
    ["id", "content", "user_id", "up_votes", "created_at", "updated_at"]
  end

  def self.attribute_names
    @attribute_names = ["id", "content", "user_id", "up_votes", "created_at", "updated_at"]
  end

  ##################################
  #   Attributes getter/setters    #
  ##################################

  def id
    @attributes['id']
  end

  def id=(val)
    type = (types[:id] ||= Virtus::Attribute.build(Fixnum))
    @attributes['id'] = type.coerce(val)
          end

  def content
    @attributes['content']
  end

  def content=(val)
    type = (types[:content] ||= Virtus::Attribute.build(String))
    @attributes['content'] = type.coerce(val)
          end

  def user_id
    @attributes['user_id']
  end

  def user_id=(val)
    type = (types[:user_id] ||= Virtus::Attribute.build(Fixnum))
    @attributes['user_id'] = type.coerce(val)
                associations['user'] = UserMock.find(val) if defined? UserMock
      end

  def up_votes
    @attributes['up_votes']
  end

  def up_votes=(val)
    type = (types[:up_votes] ||= Virtus::Attribute.build(Fixnum))
    @attributes['up_votes'] = type.coerce(val)
          end

  def created_at
    @attributes['created_at']
  end

  def created_at=(val)
    type = (types[:created_at] ||= Virtus::Attribute.build(DateTime))
    @attributes['created_at'] = type.coerce(val)
          end

  def updated_at
    @attributes['updated_at']
  end

  def updated_at=(val)
    type = (types[:updated_at] ||= Virtus::Attribute.build(DateTime))
    @attributes['updated_at'] = type.coerce(val)
          end

  ##################################
  #         Associations           #
  ##################################
# belongs_to

  def user
    associations['user']
  end

  def user=(val)
    associations['user'] = val
    write_attribute('user_id', val.id) if val.respond_to?(:persisted?) && val.persisted?
  end
# has_one
# has_many
# has_and_belongs_to_many

  ##################################
  #  Model Methods getter/setters  #
  ##################################

  def self.model_instance_methods
    @model_instance_methods ||= {}
  end

  def self.model_class_methods
    @model_class_methods ||= {"from_users_followed_by"=>:not_implemented}
  end

  def self.clear_mock
    @foreign_keys,@model_class_methods, @model_instance_methods = nil, nil, nil
    delete_all
  end

  def self.from_users_followed_by(user)
    block =  model_class_methods['from_users_followed_by']
    is_implemented(block, '::from_users_followed_by')
    instance_exec(*[user], &block)
  end

end
