require 'rails_helper'

RSpec.describe Influencer, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:birth_date) }
  it { should validate_presence_of(:instagram) }
  it { should validate_presence_of(:twitter) }

  describe "#signup_date" do
  	context "with signup date" do
  		let (:influencer) { create :influencer, signup_date: Date.yesterday - 2.days }

  		it { expect(influencer.signup_date).to eq Date.yesterday - 2.days  }
  	end

  	context "without signup date" do 
  		let (:influencer) { create :influencer, signup_date: nil }

  		it { expect(influencer.signup_date).to eq Date.today  }
  	end

 	end 
end
