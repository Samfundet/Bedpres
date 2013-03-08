module ApplicationHelper

    
  def title(page_title)
    content_for(:title) { page_title }
  end

  def participation(presentation, user)
    presentation.participations.where(:participle_id => user.id, :participle_type => user.class.name).first
  end
end
