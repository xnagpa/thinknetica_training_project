class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    user ||= User.new # guest user (not logged in)
    if user 
       user.admin? ? admin_abilities :  user_abilities
    else
      guest_abilities
        #dont forget to specify @question when aithorising destroy
    end
  end

  def guest_abilities
     can :read, [Question, Answer, Comment, Vote]  
  end

   def admin_abilities
     can :manage, :all
   end

   def user_abilities
     can :read, :all
     can :create, [Question, Answer, Comment, Vote]
     can :update, [Question, Answer, Comment, Vote], user: @user
   end
end
