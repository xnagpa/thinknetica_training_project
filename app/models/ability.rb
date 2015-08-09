class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
      # dont forget to specify @question when aithorising destroy
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
    can :create, [Question, Answer, Comment, Attachment]

    can :create, Vote do |vote|
      vote.votable.user_id != user.id
    end
    # Important operate with entity which is subordinate of other resource
    can :update, [Question, Answer, Comment, Vote], user: user
    can :destroy, [Question, Answer, Comment, Vote], user: user
    can :set_best_answer, Answer, question: { user: user }
    can :index, User
    can :me, User
    # cancan searches for the instance variable
    # if didnt find authorize manually, otherwise it will ignore blocks
    can :destroy, Attachment, attachable: { user: user }
  end
end
