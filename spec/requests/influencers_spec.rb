require 'rails_helper'

RSpec.describe "Influencers", type: :request do
  describe "GET /v1/influencers" do

    let!(:influencer) { create(:influencer, name: 'Jim Jones', instagram: '@fitness_jim', twitter: '@fitness_jim') }
    let!(:influencer2) { create(:influencer, name: 'Sally Smith', instagram: '@fitness_sally', twitter: '@sallys_squats') }
    let!(:influencer3) { create(:influencer, name: 'Jenny Jones', instagram: '@jumpingjenny', twitter: '@jumpingjenny') }

    context "with no filters" do
      it "returns all results successfully" do
        get v1_influencers_path, headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(3)
      end
    end

    context "with name filter set" do
      it "returns returns 2 trainers with last name Jones" do
        get "#{v1_influencers_path}?name=Jones", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(2)
      end

      it "returns returns 1 trainer named Sally" do
        get "#{v1_influencers_path}?name=Sally", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(1)
      end
    end

    context "with instagram filter set" do
      it "returns returns 2 trainers with instagram handle containing 'fitness'" do
        get "#{v1_influencers_path}?instagram=fitness", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(2)
      end

      it "returns returns 1 trainers with instagram handle containing 'jumping'" do
        get "#{v1_influencers_path}?instagram=Jumping", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(1)
      end
    end

    context "with twitter filter set" do
      it "returns returns 2 trainers with twitter handle containing 'fitness'" do
        get "#{v1_influencers_path}?twitter=fitness", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(1)
      end

      it "returns returns 1 trainers with twitter handle containing 'squats'" do
        get "#{v1_influencers_path}?twitter=squats", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(1)
      end
    end

    context "with name and instagram filters set" do
      it "returns the only matching influencer" do
        get "#{v1_influencers_path}?instagram=fitness&name=Jones", headers: { 'HTTP_AUTHORIZATION' => spec_token }
        expect(response).to have_http_status(200)
        expect(json_data.size).to eq(1)
      end
    end
  end
end