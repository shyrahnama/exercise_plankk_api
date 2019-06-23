module V1
	class WorkoutSerializer
	  include FastJsonapi::ObjectSerializer

	  attributes :title, :description, :duration_mins
	  belongs_to :influencer
	end
end