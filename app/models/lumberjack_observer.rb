class LumberjackObserver < ActiveRecord::Observer
  observe []
  
  def after_create(loggable)
    log_action(loggable, 'create')
  end

  def after_update(loggable)
    log_action(loggable, 'update')
  end
  
  private
    def log_action(loggable, action)
      UserLog.create(:loggable => loggable, :user => loggable.user, :action => action, :message => loggable.loggable_message_locale)
    end
end
