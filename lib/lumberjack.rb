module Lumberjack
   def self.included(base)
     base.add_observer(LumberjackObserver.instance)
   end
   
   def loggable_default_locale_options
     { :user_name => user.name, :class => self.class.human_name }
   end
   
   def loggable_message_locale
     nil
   end
end