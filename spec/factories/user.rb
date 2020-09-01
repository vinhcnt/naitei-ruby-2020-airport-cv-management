FactoryBot.define do
  factory :user do
    email {Faker::Internet.unique.email}
    password_digest {BCrypt::Password.create(Settings.validations.user.default_password)}
  end
end
