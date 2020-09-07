require "rails_helper"

RSpec.describe User, :type => :model do
  include_examples "create example users"
  let(:user) {FactoryBot.create :user}
  let!(:user_fail) {FactoryBot.build :user, email: nil}

  describe "Validations" do
    context "when all required fields given" do
      it "should be true" do
        expect(user.valid?).to eq true
      end
    end

    context "when missing required fields" do
      it "should be false" do
        expect(user_fail.valid?).to eq false
      end
    end
  end

  describe "Associations" do
    it "should has many job applications" do
      is_expected.to have_many(:job_applications).dependent(:destroy)
    end

    it "should has many job posts" do
      is_expected.to have_many(:job_posts).dependent(:destroy)
    end

    it "should has one profiles" do
      is_expected.to have_one(:profile).dependent(:destroy)
    end
  end
end
