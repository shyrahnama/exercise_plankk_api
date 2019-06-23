require 'rails_helper'

RSpec.describe Workout, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:duration_mins) }
  it { should belong_to(:influencer)}
end
