class RecentActionsObserver < ActiveRecord::Observer
  #TODO: fix it
  observe :person, :company, :task, :deal, :event#, :user

  def after_create(record)
    action = RecentAction.new(
      action_type_id: ActionType.find_by_name('create').id,
      user_id: User.current.id
    )
    action.actionable = record
    action.save
    
    item = RecentItem.new(user_id: User.current.id)
    item.itemable = record
    item.save
  end
  
  def after_update(record)
    action = RecentAction.new(
      action_type_id: ActionType.find_by_name('update').id,
      user_id: User.current.id
    )
    action.actionable = record
    action.save
    
    item = RecentItem.new(user_id: User.current.id)
    item.itemable = record
    item.save
  end
  
  def after_destroy(record)
    # Update comments for every recent action with this record
    RecentAction.where(actionable_id: record.id, actionable_type: record.class.name).each do |action|
      action.comment = record.name || record.email
      action.save
    end
    # Update comments for every recent item with this record
    RecentItem.where(itemable_id: record.id, itemable_type: record.class.name).each do |item|
      item.comment = record.name || record.email
      item.save
    end
    
    action = RecentAction.new(
      action_type_id: ActionType.find_by_name('destroy').id,
      user_id: User.current.id,
      comment: record.name || record.email
    )
    action.actionable_type = record.class.name
    action.save
  end
end
