module PresentationHelper

  def css_status presentation
    if presentation.canceled
      "error"
    elsif @current_user && @current_user.presentations.include?( presentation )
      "success"
    end
  end

end
