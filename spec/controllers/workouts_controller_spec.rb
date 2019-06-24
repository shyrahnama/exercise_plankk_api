require 'rails_helper'

RSpec.describe Api::V1::WorkoutsController, type: :controller do


  let!(:influencer) { create(:influencer) }
  let!(:workout) { create(:workout, influencer: influencer) }

  # This should return the minimal set of attributes required to create a valid
  # Workout. As you add validations to Workout, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { title: "Workout #1", description: "Some long description potentially with HTML in it or line breaks", duration_mins: 60, is_private: false, influencer_id: influencer.id }
  }

  let(:invalid_attributes) {
    { title: "Workout #1", description: "Some long description potentially with HTML in it or line breaks", duration_mins: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WorkoutsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

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
    before { get :show, params: {id: workout.to_param}, session: valid_session}

    it { expect(response).to be_successful }
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Workout" do
        expect {
          post :create, params: {workout: valid_attributes}, session: valid_session
        }.to change(Workout, :count).by(1)
      end

      it "renders a JSON response with the new workout" do
        post :create, params: {workout: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(v1_workout_url(Workout.last))
        expect(JSON.parse(response.body)["data"]["attributes"]["title"]).to eq(valid_attributes[:title])
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new workout" do

        post :create, params: {workout: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: "NewFirst NewLast", description: "new_description", duration_mins: 90, is_private: true }
      }

      it "updates the requested workout" do
        put :update, params: {id: workout.to_param, workout: new_attributes}, session: valid_session
        workout.reload
        expect(workout.title).to eq(new_attributes[:title])
        expect(workout.description).to eq(new_attributes[:description])
        expect(workout.duration_mins).to eq(new_attributes[:duration_mins])
        expect(workout.is_private).to eq(new_attributes[:is_private])
      end

      it "renders a JSON response with the workout" do
        workout = Workout.create! valid_attributes

        put :update, params: {id: workout.to_param, workout: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the workout" do
        put :update, params: {id: workout.to_param, workout: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested workout" do
      workout = Workout.create! valid_attributes
      expect {
        delete :destroy, params: {id: workout.to_param}, session: valid_session
      }.to change(Workout, :count).by(-1)
    end
  end

end
