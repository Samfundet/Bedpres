module ApplicationHelper

    
  def title(page_title)
    content_for(:title) { page_title }
  end

  def participation(presentation, user)
    presentation.participations.where(:user_id => user.id).first
  end
end
