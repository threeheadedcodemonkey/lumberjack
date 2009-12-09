class UserLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :loggable, :polymorphic => :true
  
  # TODO: Test this
  default_scope :order => "created_at DESC"
  
  def humanize(options = {})
    locale = (message) ? message : action
    I18n.translate("lumberjack.#{locale}",  options.merge(loggable.loggable_default_locale_options))
  end
end
