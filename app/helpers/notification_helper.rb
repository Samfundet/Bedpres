module NotificationHelper
  
  def notify(users, descritpion, presentation)
    
    users.each do |user|
      Notification.create!({:notifiable => user, :descritpion => descritpion, :presentation_id => presentation.id})
    end

  end

end
