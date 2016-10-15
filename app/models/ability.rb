class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
    elsif User.current_role == 'senior_manager'
      can :manage, Lead do |lead|
        user.memberships.where(department: lead.department, role: ['chief', 'marketer', 'senior_manager', 'manager']).present?
      end
      
      can :manage, Contact do |contact|
        user.memberships.where(department: contact.department, role: ['chief', 'marketer', 'senior_manager', 'manager']).present?
      end
      
    elsif User.current_role == 'manager'
      can :manage, Lead do |lead|
        user.memberships.where(department: lead.department, role: ['chief', 'marketer', 'senior_manager', 'manager']).present?
      end
      
      can :manage, Contact do |contact|
        user.memberships.where(department: contact.department, role: ['chief', 'marketer', 'senior_manager', 'manager']).present?
      end
    else
      
    end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
