module Lumberjack
   def self.included(base)
     # This is the observer that logs the saves
     base.add_observer(LumberjackObserver.instance)

     # This is added to remove the logs of loggables deleted
     base.has_one :user_log, :foreign_key => :loggable_id,  :dependent => :destroy
   end
   
   def loggable_default_locale_options
     { :user_name => user.name, :class => self.class.human_name }
   end
   
   def loggable_message_locale
     nil
   end
end