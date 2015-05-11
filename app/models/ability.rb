class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    # Guest users
    can [:home, :about, :contact, :help], StaticPagesController
    
    if user.role == "user" && user.approved == true
      can [:home, :about, :contact, :help, :useronlypage], StaticPagesController
      can [:index, :show], Species
      can [:index, :map, :show], Site
      can [:index, :map, :show, :new, :create], Sighting
      can [:edit, :update, :destroy], Sighting do |sighting|
        sighting.creator == user || sighting.spotter == user
      end
    
    end    
    
    if user.role == "superuser" && user.approved == true      
      can [:home, :about, :contact, :help, :useronlypage, :superuseronlypage], StaticPagesController
      can :crud, Species
      can :crud, Site
      can :map, Site
      can [:index, :map, :show, :new, :create], Sighting
      can [:edit, :update, :destroy], Sighting do |sighting|
        sighting.creator == user || sighting.spotter == user
      end
    end
    
    if user.role == "admin" && user.approved == true      
      can [:manage], StaticPagesController
      can :crud, Species
      can :crud, Site
      can :crud, Sighting
      can :map, Site
      can :map, Sighting
    end
    
  end
end
