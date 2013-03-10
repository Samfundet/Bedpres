module PresentationHelper

  def css_status(presentation)
    if presentation.canceled
      "error"
    elsif ( @current_user && presentation.participants.include?(@current_user) )
      "success"
    end
  end

end
