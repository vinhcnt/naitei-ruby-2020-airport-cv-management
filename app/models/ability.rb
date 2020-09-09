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

  private

  def candidate_ability user
    can :manage, User, id: user.id
    can :manage, Profile, user_id: user.id
    can :manage, [Education, Experience], profile_id: user.profile_id
    can :read, JobApplication
    can :update, user.job_applications do |job_application|
      !(job_application.denied? || job_application.cancelled?)
    end
    can :create, JobApplication do |job_application|
      create_job_application_ability job_application, user
    end
  end

  def recruiter_ability _user
    can :manage, JobPost
    can :read, [User, Profile, Education, Experience]
    can [:read, :update], JobApplication
  end

  def create_job_application_ability job_application, user
    old_and_same_j_app = user.job_applications
                             .where(job_post_id: job_application.job_post_id)
                             .order(created_at: :desc)
                             .first
    !old_and_same_j_app || old_and_same_j_app.denied? || old_and_same_j_app.cancelled?
  end
end
