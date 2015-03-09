module MentorHelper
  def render_unread_notification(activity_type, object_id, object_type)
    render_msg = ''
    count = current_user.count_unread_notification(activity_type, object_id, object_type)
    if count > 0
      render_msg += "<span class='badge bg-primary'> #{count} </span>"
    end
    render_msg.html_safe
  end
end
