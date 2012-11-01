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
    includes :guest
  end

  role :presentation_administrator do
    includes :guest
    includes :user

    has_permission_on :presentations, :to => :manage
  end

end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete, :search]
  privilege :read,   :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end