authorization do

  role :guest do
    has_permission_on :presentations, :to => :read
    has_permission_on :users, :to => [:create,
                                      :forgot_password,
                                      :generate_forgot_password_email,
                                      :reset_password,
                                      :change_password,
                                      :verify_account]
    has_permission_on :sessions, :to => :manage
  end

  role :user do
    includes :guest
    has_permission_on :participations, :to => [ :create, :delete ]
    has_permission_on :users, :to => [:update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on :notifications, :to => [:destroy] do
      if_attribute :user_id => is { user.id }
    end
  end

  role :medlem do
    includes :guest
  end

  role :presentation_administrator do
    includes :guest
    has_permission_on :presentations, :to => [:manage, :toggle_cancel]
  end

  role :lim_web do
    includes :presentation_administrator
  end

end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read,   :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
