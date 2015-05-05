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
    end    
    
    if user.role == "superuser" && user.approved == true      
      can [:home, :about, :contact, :help, :useronlypage, :superuseronlypage], StaticPagesController
      can :crud, Species
      can :crud, Site
      can :map, Site
    end
    
    if user.role == "admin" && user.approved == true      
      can [:manage], StaticPagesController
      can :crud, Species
      can :crud, Site
      can :map, Site
    end
        
    # if user.role == "technician" && user.approved == true
      # can [:edit, :update], JobRequest do |job_request|
        # job_request.analysis_type.technicians.include? user
      # end
    # end
#     
    # if user.role == "researcher" && user.approved == true
      # can [:edit, :update, :destroy], JobRequest do |job_request|
        # job_request.researcher_id == user.id
      # end
    # end
    
  end
end
