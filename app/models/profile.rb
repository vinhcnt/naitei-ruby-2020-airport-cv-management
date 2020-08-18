class Profile < ApplicationRecord
  belongs_to :gender
  belongs_to :user
  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy

  delegate :name, to: :gender, prefix: true, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
