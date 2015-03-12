module ApplicationHelper

  def flash_messages
    return nil if flash.empty?
    flash_messages = ''
    flash.each { |key, msg| flash_messages += content_tag(:div, msg) }
    content_tag(:div, flash_messages.html_safe, :class => 'notices')
  end

  def extract_date(timestamp)
  	timestamp.strftime("%B %d, %Y")
  end

  def extract_time(timestamp)
  	timestamp.strftime("%I:%M%p")
  end
  def random_background
    image_list = ["search_background1.png", "search_background2.png"]
    "background: url('/assets/#{image_list.shuffle[0]}') no-repeat scroll 0% 0% transparent;"
  end
  def unread_messages(user)
    user.mailbox.inbox(:unread => true).count
  end

end