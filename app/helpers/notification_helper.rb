module NotificationHelper
  
  def notify(users, descritpion, presentation)
    
    users.each do |user|
      Notification.create!({:user_id => user.id, :descritpion => descritpion, :presentation_id => presentation.id})
    end

  end

end