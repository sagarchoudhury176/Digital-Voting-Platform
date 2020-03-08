# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :index, Election
    can :show, Election

    can :index, Candidate
    can :show, Candidate

    if user.is? 'admin'
      can :manage, Candidate
      can :mange, Election
    end

    if user.is? 'candidate'
      can :manage, Candidate
    end

    if user.is? 'user'
      can :vote, Election
    end
  end
end
