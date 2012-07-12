class RecentActionsObserver < ActiveRecord::Observer
  observe :person, :company, :task, :deal, :event, :user

  def after_create(record)
    record.recent_actions.create(
      action_type_id: ActionType.find_by_name('create').id,
      user_id: User.current.id
    )
    record.recent_items.create(user_id: User.current.id)
  end
  
  def after_update(record)
    record.recent_actions.create(
      action_type_id: ActionType.find_by_name('update').id,
      user_id: User.current.id
    )
    record.recent_items.create(user_id: User.current.id)
  end
  
  def after_destroy(record)
    action = RecentAction.new(
      action_type_id: ActionType.find_by_name('destroy').id,
      user_id: User.current.id,
      comment: record.name
    )
    action.actionable_type = record.class.name
    action.save
  end    
end
