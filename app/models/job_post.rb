class JobPost < ApplicationRecord
  JOBPOST_PARAMS = %i(title location salary_from salary_to note description requirement category_id unit_id).freeze

  belongs_to :category
  belongs_to :user
  belongs_to :unit

  delegate :title, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :unit, prefix: true, allow_nil: true

  validates :user_id, presence: true
  validates :title, presence: true,
    length: {minimum: Settings.validations.job_post.title_min}
  validates :location, presence: true,
    length: {minimum: Settings.validations.job_post.content_min}
  validates :salary_from, presence: true,
    length: {minimum: Settings.validations.job_post.number_min},
    numericality: {greater_than: Settings.validations.job_post.zero}
  validates :salary_to, presence: true,
    length: {minimum: Settings.validations.job_post.number_min},
    numericality: {greater_than: Settings.validations.job_post.zero}
  validates :description, presence: true,
    length: {minimum: Settings.validations.job_post.content_min}
  validates :requirement, presence: true,
    length: {minimum: Settings.validations.job_post.content_min}

  scope :home_recent_jobs, ->{order(created_at: :desc).limit Settings.job}
end
