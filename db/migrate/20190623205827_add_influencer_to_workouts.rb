class AddInfluencerToWorkouts < ActiveRecord::Migration[5.2]
  def change
    add_reference :workouts, :influencer, foreign_key: true
  end
end
