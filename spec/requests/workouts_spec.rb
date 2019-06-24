require 'rails_helper'

RSpec.describe "Workouts", type: :request do
  describe "GET /v1/workouts" do

    let!(:influencer) { create(:influencer, name: 'Jim Jones', instagram: '@fitness_jim', twitter: '@fitness_jim') }
    let!(:workout_set) { create_list :workout, 3, influencer: influencer }

    let!(:influencer2) { create(:influencer, name: 'Sally Smith', instagram: '@fitness_sally', twitter: '@sallys_squats') }
    let!(:workouts_set2) { create_list :workout, 3, influencer: influencer2 }
    let!(:private_workout) { create(:workout, influencer: influencer2, is_private: true) }

    context "with no filters" do
      it "returns all results successfully and defaults to public workouts" do
        get v1_workouts_path, headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(6)
      end
    end

    context "with private set to 'any'" do
      it "returns all results successfully and contains both private and public workouts" do
        get "#{v1_workouts_path}?is_private=any", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(7)
      end
    end

    context "with influencer set to influencer2, using parameterized URL" do
      it "returns all results successfully and defaults to public workouts" do
        get "#{v1_workouts_path}?influencer_id=#{influencer2.id}", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(3)
      end
    end

    context "with influencer set to influencer2, using canonical URL" do
      it "returns all results successfully and defaults to public workouts" do
        get "#{v1_influencer_workouts_path(influencer2)}", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(3)
      end
    end

    context "with influencer set to influencer2, using canonical URL and is_private set to 'any'" do
      it "returns all results successfully and returns all workouts" do
        get "#{v1_influencer_workouts_path(influencer2)}?is_private=any", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(4)
      end
    end


    # context "with title filter set" do
    #   describe "to a matching workout" do 
    #     it "returns exactly 1 title" do
    #       get "#{v1_workouts_path}?title=Workout%20Number%204", headers: { 'HTTP_AUTHORIZATION' => spec_token }
    #       expect(response).to have_http_status(200)
    #       expect(json_data.size).to eq(2)
    #     end
    #   end

    #   describe "to no matching workouts" do
    #     it "returns exactly 1 title" do
    #       get "#{v1_workouts_path}?title=Workout%20Number%208", headers: { 'HTTP_AUTHORIZATION' => spec_token }
    #       expect(response).to have_http_status(200)
    #       expect(json_data.size).to eq(2)
    #     end
    #   end
    # end

    # context "with instagram filter set" do
    #   it "returns returns 2 trainers with instagram handle containing 'fitness'" do
    #     get "#{v1_influencers_path}?instagram=fitness", headers: { 'HTTP_AUTHORIZATION' => spec_token }
    #     expect(response).to have_http_status(200)
    #     expect(json_data.size).to eq(2)
    #   end

    #   it "returns returns 1 trainers with instagram handle containing 'jumping'" do
    #     get "#{v1_influencers_path}?instagram=Jumping", headers: { 'HTTP_AUTHORIZATION' => spec_token }
    #     expect(response).to have_http_status(200)
    #     expect(json_data.size).to eq(1)
    #   end
    # end

    # context "with twitter filter set" do
    #   it "returns returns 2 trainers with twitter handle containing 'fitness'" do
    #     get "#{v1_influencers_path}?twitter=fitness", headers: { 'HTTP_AUTHORIZATION' => spec_token }
    #     expect(response).to have_http_status(200)
    #     expect(json_data.size).to eq(1)
    #   end

    #   it "returns returns 1 trainers with twitter handle containing 'squats'" do
    #     get "#{v1_influencers_path}?twitter=squats", headers: { 'HTTP_AUTHORIZATION' => spec_token }
    #     expect(response).to have_http_status(200)
    #     expect(json_data.size).to eq(1)
    #   end
    # end

    # context "with name and instagram filters set" do
    #   it "returns the only matching influencer" do
    #     get "#{v1_influencers_path}?instagram=fitness&name=Jones", headers: { 'HTTP_AUTHORIZATION' => spec_token }
    #     expect(response).to have_http_status(200)
    #     expect(json_data.size).to eq(1)
    #   end
    # end
  end
end