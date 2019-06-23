class Influencer::Demographics
  def initialize(influencer)
    @influencer = influencer
  end

  def age
    return unless @influencer.birth_date
    ((Date.today - @influencer.birth_date)/365).floor
  end
end
