# spec/integration/influencers_spec.rb
require 'swagger_helper'

describe 'Influencers API' do

  path '/v1/influencers' do  

    post 'Creates an influencer' do
      tags 'Influencers'
      consumes 'application/json'
      security [ http: [] ]
      parameter name: :influencer, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          instagram: { type: :string },
          twitter: { type: :string },
          birth_date: { type: :date }
        },
        required: [ 'name', 'instagram', 'twitter', 'birth_date' ]
      }

      response '201', 'influencer created' do
        let(:Authorization) { spec_token }
        let(:influencer) { { name: 'First Last', instagram: '@influencer_ig', twitter: '@infleuncer_tw', birth_date: 25.years.ago } }
        run_test!
      end

      response '401', 'not authorized' do
        let(:influencer) { { name: 'First Last', instagram: '@influencer_ig', twitter: '@infleuncer_tw', birth_date: 25.years.ago } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { spec_token }
        let(:blog) { { name: 'First Last' } }
        run_test!
      end
    end
  end

  path '/v1/influencers/{id}' do

    get 'Retrieves an influencer' do
      tags 'Influencers'
      produces 'application/json'
      security [ http: [] ]

      parameter name: :id, :in => :path, :type => :string

      response '200', 'influencer found' do
        schema type: :object,
          properties: {
            id: { type: :integer }
          },
          required: [ 'id' ]

        let(:id) { Influencer.create(name: 'First Last', instagram: '@influencer_ig', twitter: '@infleuncer_tw', birth_date: 25.years.ago).id }
        run_test!
      end

      response '404', 'influencer not found' do
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