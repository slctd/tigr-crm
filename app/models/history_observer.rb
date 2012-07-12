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
      item = record.historable || record.deal || record.event
      item.recent_actions.create(
        action_type_id: ActionType.find_by_name('update').id,
        user_id: User.current.id
      )
    end
end
