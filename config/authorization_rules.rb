authorization do

  role :guest do
    has_permission_on :presentations, :to => :read
    has_permission_on :users, :to => :create
    has_permission_on :sessions, :to => :manage
  end

  role :user do
    includes :guest
  end

  role :medlem do
    includes :user
  end

  role :presentation_administrator do
    includes :medlem

    has_permission_on :presentations, :to => :manage
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