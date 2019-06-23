module V1
	class InfluencerSerializer
	  include FastJsonapi::ObjectSerializer
	  attributes :name, :instagram, :twitter, :signup_date
	  set_type :trainer

	  attribute :age do |influencer|
	  	influencer.age
	  end
	end
end