class Workout < ApplicationRecord

	belongs_to :influencer

	validates :title, :duration_mins, presence: true
	validates :duration_mins, numericality: { greater_than: 0 }
	validates :is_private, :inclusion => {:in => [true, false]}

end
