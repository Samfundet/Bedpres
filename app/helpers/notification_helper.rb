module NotificationHelper
  
  def notify(participants, descritpion, presentation)
    
    participants.each do |participant|
      Notification.create!({:notifiable => participant, :descritpion => descritpion, :presentation_id => presentation.id})
    end

  end

end
