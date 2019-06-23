FactoryBot.define do
  factory :workout do
		sequence(:title) { |n| "Workout ##{n}" }
    description { "Lorem ipsum dolor sit amet, ex diceret perpetua posidonium sea. Pri libris possim latine eu. \ 
    							 Vivendo pericula no sit. Eum diam admodum patrioque ea, ad ullum munere vituperata duo. Duo molestie \
    							 deserunt ea. Vim in nobis eripuit mentitum." }
    duration_mins { 60}
    is_private { false }

    influencer
  end
end
