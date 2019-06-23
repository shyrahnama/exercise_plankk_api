class Influencer < ApplicationRecord

  # Using a value class is definitely overkill for the spec of this application, but doing it anyway
  # for the sake of demonstrating what I would do with more complex needs
  delegate :age, to: :demographic_values

  private

  def demographic_values
    @demographic_values ||= Influencer::Demographics.new(self)
  end
end
