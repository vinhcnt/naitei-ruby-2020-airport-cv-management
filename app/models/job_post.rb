class JobPost < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :unit

  delegate :title, to: :category, prefix: true, allow_nil: true
end
