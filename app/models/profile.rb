class Profile < ApplicationRecord
  PROFILE_PARAMS = %i(first_name last_name introduction date_of_birth gender_id address phone_number) \
    << {educations_attributes: %i(id college major date_from date_to certification additional_information _destroy)} \
    << {experiences_attributes: %i(id company_name job_position date_from date_to additional_information _destroy)}
  VALID_PHONE_NUMBER_REGEX = Settings.validations.profile.phone_number

  belongs_to :gender, optional: true
  belongs_to :user
  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy

  accepts_nested_attributes_for :educations, :experiences, allow_destroy: true, reject_if: :all_blank

  delegate :name, to: :gender, prefix: true, allow_nil: true

  validates :first_name, :last_name, presence: true,
    length: {minimum: Settings.validations.profile.first_name.minimum,
             maximum: Settings.validations.profile.first_name.maximum}
  validates :date_of_birth, presence: true
  validates :address, presence: true,
    length: {maximum: Settings.validations.profile.address.maximum}
  validates :introduction, allow_nil: true,
    length: {maximum: Settings.validations.profile.introduction.maximum}
  validates :phone_number, presence: true,
    format: {with: VALID_PHONE_NUMBER_REGEX},
    uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
