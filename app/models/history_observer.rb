class HistoryObserver < ActiveRecord::Observer
  def after_create(record)
    log record
  end
  
  def after_update(record)
    log record
  end
  
  def after_destroy(record)
    log record
  end  
  
  private 
    def log(record)
      object = record.historable || record.deal || record.event
      action = RecentAction.new(
        action_type_id: ActionType.find_by_name('update').id,
        user_id: User.current.id
      )
      action.actionable = object
      action.save
      
      item = RecentItem.new(user_id: User.current.id)
      item.itemable = object
      item.save
    end
end
