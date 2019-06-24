module Api::V1
  class InfluencersController < ApiController
    before_action :authorize_request
    before_action :set_influencer, only: [:show, :update, :destroy]

    InfluencerReducer = Rack::Reducer.new(
      Influencer.all,
      ->(name:) { where('lower(name) like ?', "%#{name.downcase}%") },
      ->(instagram:) { where('lower(instagram) like ?', "%#{instagram.downcase}%") },
      ->(twitter:) { where('lower(twitter) like ?', "%#{twitter.downcase}%") }
    )

    # GET /v1/influencers
    def index
      @filtered_influencers = InfluencerReducer.apply(params)
      @influencers = ::V1::InfluencerSerializer.new(@filtered_influencers)

      render json: @influencers
    end

    # GET /v1/influencers/1
    def show
      render_404 unless @influencer
      @influencer = ::V1::InfluencerSerializer.new(@influencer)

      render json: @influencer
    end

    # POST /v1/influencers
    def create
      @influencer = Influencer.new(influencer_params)

      if @influencer.save
        render json: ::V1::InfluencerSerializer.new(@influencer), status: :created, location: v1_influencer_url(@influencer)
      else
        render json: @influencer.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/influencers/1
    def update
      if @influencer.update(influencer_params)
        render json: ::V1::InfluencerSerializer.new(@influencer)
      else
        render json: @influencer.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v1/influencers/1
    def destroy
      @influencer.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_influencer
        @influencer = Influencer.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def influencer_params
        params.require(:influencer).permit(:name, :instagram, :twitter, :birth_date, :signup_date)
      end
  end
end
