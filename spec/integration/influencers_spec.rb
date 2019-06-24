# spec/integration/influencers_spec.rb
require 'swagger_helper'

describe 'Influencers API' do

  path '/v1/influencers' do 
    get 'Lists influencers' do
      tags 'Influencers'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'JWT authorization token. Shayan to provide.'
      parameter name: :name, in: :query, type: :string, required: false, description: 'Filter list of influencers by name'
      parameter name: :instagram, in: :query, type: :string, required: false, description: 'Filter list of influencers by instagram handle'
      parameter name: :twitter, in: :query, type: :string, required: false, description: 'Filter list of influencers by twitter handle'

      response '200', 'influencers listed, with filters applied if specified' do
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
                      name: { type: :string },
                      instagram: { type: :string },
                      twitter: { type: :string },
                      signup_date: { type: :string },
                      age: { type: :integer },
                      relationships: {
                        type: :object,
                        properties: {
                          workouts: { 
                            type: :array,
                            items: {
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

        run_test!
      end
    end
  end

  path '/v1/influencers' do  
    post 'Creates an influencer' do
      tags 'Influencers'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'JWT authorization token'
      parameter name: :influencer, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          instagram: { type: :string },
          twitter: { type: :string },
          birth_date: { type: :string }
        },
        required: [ 'name', 'instagram', 'twitter', 'birth_date' ]
      }

      response '201', 'influencer created' do
        let(:Authorization) { spec_token }
        let(:influencer) { { name: 'First Last', instagram: '@influencer_ig', twitter: '@infleuncer_tw', birth_date: 25.years.ago } }
        run_test!
      end

      response '401', 'not authorized' do
        let(:Authorization) { nil }
        let(:influencer) { { name: 'First Last', instagram: '@influencer_ig', twitter: '@infleuncer_tw', birth_date: 25.years.ago } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { spec_token }
        let(:influencer) { { name: 'First Last' } }
        run_test!
      end
    end
  end

  path '/v1/influencers/{id}' do
    get 'Retrieves an influencer' do
      tags 'Influencers'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'JWT authorization token'
      parameter name: :id, in: :path, type: :string, required: true

      response '200', 'influencer found' do
        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                id: { type: :integer },
                type: { type: :string },
                attributes: { 
                  type: :object, 
                  properties: {
                    name: { type: :string },
                    instagram: { type: :string },
                    twitter: { type: :string },
                    signup_date: { type: :string },
                    age: { type: :integer },
                    relationships: {
                      type: :object,
                      properties: {
                        workouts: { 
                          type: :array,
                          items: {
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

        let(:Authorization) { spec_token }
        let(:id) { Influencer.create(name: 'First Last', instagram: '@influencer_ig', twitter: '@infleuncer_tw', birth_date: 25.years.ago).id }
        run_test!
      end

      response '404', 'influencer not found' do
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

  path '/v1/influencers/{influencer_id}/workouts' do 
    get 'Lists workouts for a given influencer' do
      tags 'Workouts'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'JWT authorization token. Shayan to provide.'
      parameter name: :influencer_id, in: :path, type: :string, required: true

      parameter name: :title, in: :query, type: :string, required: false, description: 'Filter list of workouts by title'
      parameter name: :description, in: :query, type: :string, required: false, description: 'Filter list of workouts by keywords in description (simple search)'
      parameter name: :is_private, in: :query, type: :string, required: false, description: "Filter list by whether workout is public or private. Allowable values are 'any', 'true' or 'false'"

      response '200', 'workouts for influencer are returned' do
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
        let(:influencer) { create :influencer }
        let(:workout) { Workout.create( title: "Workout #1", description: "Some long description potentially with HTML in it or line breaks", 
                                   duration_mins: 60, is_private: false, influencer_id: influencer.id).id }
        let(:influencer_id) { influencer.id }

        run_test!
      end
    end
  end
end