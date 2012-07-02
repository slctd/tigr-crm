module EventsHelper
  def link_to_change_status(event)
    text = t(".open")
    text = t(".close") if event.opened?
    link_to text, event_change_status_path(event)
  end
end
