require 'rails_helper'

RSpec.describe Api::V1::InfluencersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Influencer. As you add validations to Influencer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: "First Last", instagram: "@influencer_ig", twitter: "@infleuncer_tw", birth_date: 25.years.ago }
  }

  let(:invalid_attributes) {
    { name: nil, instagram: "@influencer_ig", twitter: "@infleuncer_tw", birth_date: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InfluencersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let!(:influencer) { create(:influencer) }
  let!(:influencer2) { create(:influencer) }


  before do
    add_authorization_header
  end

  describe "GET #index" do
    context "when not authorized" do
      before { request.env["HTTP_AUTHORIZATION"] = "abc123" }
      before { get :index, params: {}, session: valid_session }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context "when authorized" do 
      before { get :index, params: {}, session: valid_session }

      it { expect(response).to have_http_status(:success) }
      it { expect(JSON.parse(response.body)["data"].length).to eq(2) }
    end
  end

  describe "GET #show" do
    before { get :show, params: {id: influencer.to_param}, session: valid_session}

    it { expect(response).to be_successful }
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Influencer" do
        expect {
          post :create, params: {influencer: valid_attributes}, session: valid_session
        }.to change(Influencer, :count).by(1)
      end

      it "renders a JSON response with the new influencer" do
        post :create, params: {influencer: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(v1_influencer_url(Influencer.last))
        expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq(valid_attributes[:name])
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new influencer" do

        post :create, params: {influencer: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "NewFirst NewLast", instagram: "@influencer_ig", twitter: "@infleuncer_tw", birth_date: 25.years.ago }
      }

      it "updates the requested influencer" do
        put :update, params: {id: influencer.to_param, influencer: new_attributes}, session: valid_session
        influencer.reload
        expect(influencer.name).to eq(new_attributes[:name])
      end

      it "renders a JSON response with the influencer" do
        put :update, params: {id: influencer.to_param, influencer: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the influencer" do
        put :update, params: {id: influencer.to_param, influencer: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested influencer" do
      influencer = Influencer.create! valid_attributes
      expect {
        delete :destroy, params: {id: influencer.to_param}, session: valid_session
      }.to change(Influencer, :count).by(-1)
    end
  end

end
