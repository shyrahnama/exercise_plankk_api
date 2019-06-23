module V1
	class InfluencerSerializer
	  include FastJsonapi::ObjectSerializer
	  attributes :name, :instagram, :twitter, :signup_date

	  attribute :age do |influencer|
	  	influencer.age
	  end
	end
end