class JobPost < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :unit

  delegate :title, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :unit, prefix: true, allow_nil: true

  scope :home_recent_jobs, ->{order(created_at: :desc).limit Settings.job}
end
