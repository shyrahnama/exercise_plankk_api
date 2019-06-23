FactoryBot.define do
  factory :influencer do
		sequence(:name) { |n| "FirstName LastName#{n}" }
    instagram { "@fitnessphreak_ig" }
    twitter { "@fitness_phreak_tw" }
    birth_date { 35.years.ago }

    trait :with_signup_date do
	    signup_date { Date.yesterday }
	  end
  end
end
