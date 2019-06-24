module Api::V1
  class WorkoutsController < ApiController
    before_action :authorize_request
    before_action :set_workout, only: [:show, :update, :destroy]

    WorkoutReducer = Rack::Reducer.new(
      Workout.all,
      ->(title:) { where('lower(title) like ?', "%#{title.downcase}%") },
      ->(description:) { where('lower(description) like ?', "%#{description.downcase}%") },
      ->(is_private: 'false') { where('is_private IN (?)', (is_private.present? && is_private == 'any') ? [true, false] : 
                                                         ((is_private.present? && is_private == 'true') ? [true] : [false])) },
      ->(influencer_id:) { where('influencer_id = ?', influencer_id) },
    )

    # GET /v1/workouts
    def index
      @filtered_workouts = WorkoutReducer.apply(params)
      @workouts = ::V1::WorkoutSerializer.new(@filtered_workouts)

      render json: @workouts
    end

    # GET /v1/workouts/1
    def show
      render_404 unless @workout

      render json: ::V1::WorkoutSerializer.new(@workout)
    end

    # POST /v1/workouts
    def create
      @workout = Workout.new(workout_params)

      if @workout.save
        render json: ::V1::WorkoutSerializer.new(@workout), status: :created, location: v1_workout_url(@workout)
      else
        render json: @workout.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/workouts/1
    def update
      if @workout.update(workout_params)
        render json: ::V1::WorkoutSerializer.new(@workout)
      else
        render json: @workout.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v1/workouts/1
    def destroy
      @workout.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_workout
        @workout = Workout.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def workout_params
        params.require(:workout).permit(:title, :description, :duration_mins, :is_private, :influencer_id)
      end
  end
end
