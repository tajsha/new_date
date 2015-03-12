desc "Remove receipts older than a day"

task :remove_old_receipts => :environment do
Receipt.delete_all ["created_at < ?", 90.day.ago]
end

desc "Remove notifications older than a day"

task :remove_old_notifications => :environment do
Notification.delete_all ["created_at < ?", 90.day.ago]
end

desc "Remove conversations older than a day"


task :remove_old_conversations => :environment do
Conversation.delete_all ["created_at < ?", 90.day.ago]
end