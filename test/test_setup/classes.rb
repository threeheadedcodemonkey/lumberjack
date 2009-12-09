class Foo < ActiveRecord::Base
  include Lumberjack
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :foos
end

class Bar < ActiveRecord::Base
  include Lumberjack
  belongs_to :user
  def loggable_message_locale
    'custom.create'
  end
end
