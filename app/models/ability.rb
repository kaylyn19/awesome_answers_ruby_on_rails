# frozen_string_literal: true

# Cancancan assumes you have a method called 'current_user' available in your application controller. 
# Cancncan gets automatically initialized with 'current_user' passed to the initialize method.
class Ability
  # run: rails g cancan:ability
  # first model file with no migration associated
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    if user.is_admin?
      can :manage, :all
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

    #use the 'alias_action' method to assign names
    alias_action :create, :read, :update, :destroy, to: :crud
    # To define a permission for a User, use the 'can' method inside of this class' initilize method.
    # It takes the following args in order:
    # - The name of the action you are testing permission for ,as a symbol.
    # - The class of an object we are testing the action against (i.e. Question, Answer, User, etc.)
    # - A block that is used to determine whether or not a user can perform that action on the resource/class.
    # - If the block returns true, the user can perofrm the action, otherwise, they can't.
    can(:crud, Question) do |question|
      question.user == user || user.is_admin? # or question.user_id == user.id
    end

    can(:crud, Answer) do |answer|
      answer.user == user || 
      answer.question.user == user.id # if we wanted to allow both the answer owner and the question owner to have the ability to ':crud' 
    end

    # can write abilities like:
    # can :crud, Question, user_id: user.id

    can(:crud, JobPost) do |job_post|
      job_post.user == user
    end

    can(:like, Question) do |question|
      user.present? && question.user != user
    end
  end
end
