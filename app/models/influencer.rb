class Influencer < ApplicationRecord
  has_many :workouts

  validates :name, :birth_date, :instagram, :twitter, presence: true

  before_create :set_signup_date

  # Using a value class is definitely overkill for the scope of this exercise, but doing it anyway
  # for the sake of demonstrating what I would do with more complex needs to run calculations, to keep the model DRY
  delegate :age, to: :demographic_values

  private

  def demographic_values
    @demographic_values ||= Influencer::Demographics.new(self)
  end

  def set_signup_date
  	self.signup_date = Date.today unless signup_date.present?
  end
end
