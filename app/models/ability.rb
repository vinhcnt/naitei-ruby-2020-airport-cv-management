# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user
    can :read, JobPost
    return if user.nil?

    candidate_ability user if user.has_role? :candidate

    recruiter_ability user if user.has_role? :recruiter

    can :manage, :all if user.has_role? :admin
  end

  def candidate_ability user
    can :manage, User, id: user.id
    can :manage, Profile, user_id: user.id
    can :manage, [Education, Experience], profile_id: user.profile_id
    can [:create, :read], user.job_applications
    can :update, user.job_applications do |job_application|
      !(job_application.denied? || job_application.cancelled?)
    end
  end

  def recruiter_ability _user
    can :manage, JobPost
    can :read, [User, Profile, Education, Experience]
    can :manage, JobApplication
  end
end
