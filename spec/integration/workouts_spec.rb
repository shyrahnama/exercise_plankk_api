# spec/integration/workouts_spec.rb
require 'swagger_helper'

describe 'Workouts API' do

  path '/v1/workouts' do 
    get 'Lists workouts' do
      tags 'Workouts'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'JWT authorization token. Shayan to provide.'
      parameter name: :title, in: :query, type: :string, required: false, description: 'Filter list of workouts by title'
      parameter name: :description, in: :query, type: :string, required: false, description: 'Filter list of workouts by keywords in description (simple search)'
      parameter name: :is_private, in: :query, type: :string, required: false, description: "Filter list by whether workout is public or private. Allowable values are 'any', 'true' or 'false'"
      parameter name: :influencer_id, in: :query, type: :string, required: false, description: 'Can be in query, but can also be in path as specified in Influencer API'

      response '200', 'workouts are listed, with filters applied if specified' do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  type: { type: :string },
                  attributes: { 
                    type: :object, 
                    properties: {
                      title: { type: :string },
                      description: { type: :string },
                      duration_mins: { type: :integer },
                      relationships: {
                        type: :object,
                        properties: {
                          influencer: { 
                            type: :object,
                            properties: {
                              data: {
                                type: :object,
                                properties: {
                                  id: { type: :integer },
                                  type: { type: :string }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }


        let(:Authorization) { spec_token }

        run_test!
      end
    end
  end

  path '/v1/workouts' do  
    post 'Creates a workout' do
      tags 'Workouts'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'JWT authorization token. Shayan to provide.'
      parameter name: :workout, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          duration_mins: { type: :integer },
          is_private: { type: :boolean },
          influencer_id: { type: :integer }
        },
        required: [ 'title', 'duration_mins', 'influencer_id' ]
      }

      response '201', 'workout created' do
        let(:Authorization) { spec_token }
        let(:influencer) { create :influencer }
        let(:workout) { { title: "Workout #1", description: "Some long description potentially with HTML in it or line breaks", 
                             duration_mins: 60, is_private: false, influencer_id: influencer.id } }
        run_test!
      end

      response '401', 'not authorized' do
        let(:Authorization) { nil }
        let(:influencer) { create :influencer }
        let(:workout) { { title: "Workout #1", description: "Some long description potentially with HTML in it or line breaks", 
                             duration_mins: 60, is_private: false, influencer_id: influencer.id } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { spec_token }
        let(:workout) { { title: "Workout #1", description: "Some long description potentially with HTML in it or line breaks", 
                             duration_mins: 60, is_private: false, influencer_id: nil} }
        run_test!
      end
    end
  end

  path '/v1/workouts/{id}' do
    get 'Retrieves a workout' do
      tags 'Workouts'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'JWT authorization token. Shayan to provide.'
      parameter name: :id, in: :path, type: :string, required: true

      response '200', 'workout found' do
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                id: { type: :string },
                type: { type: :string },
                attributes: { 
                  type: :object, 
                  properties: {
                    title: { type: :string },
                    description: { type: :string },
                    duration_mins: { type: :integer },
                    relationships: {
                      type: :object,
                      properties: {
                        influencer: { 
                          type: :object,
                          properties: {
                            data: {
                              type: :object,
                              properties: {
                                id: { type: :integer },
                                type: { type: :string }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }

        let(:Authorization) { spec_token }
        let(:influencer) { create :influencer }
        let(:id) { Workout.create( title: "Workout #1", description: "Some long description potentially with HTML in it or line breaks", 
                                   duration_mins: 60, is_private: false, influencer_id: influencer.id).id }
        run_test!
      end

      response '404', 'workout not found' do
        let(:Authorization) { spec_token }
        let(:id) { 'invalid' }
        run_test!
      end

      # response '406', 'unsupported accept header' do
      #   let(:'Accept') { 'application/foo' }
      #   run_test!
      # end
    end
  end
end