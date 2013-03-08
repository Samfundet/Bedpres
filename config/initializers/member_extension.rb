Rails.application.config.to_prepare do
  Member.class_eval do
    has_many :participations, :as => :participle, :dependent => :destroy
    has_many :notifications, :as => :notifiable, :dependent => :destroy, :order => "created_at DESC"
    has_many :presentations, :through => :participations

    def surname
      etternavn
    end

    def firstname
      fornavn
    end

    def email
      mail
    end
  end
end
