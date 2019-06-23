module Api::V1
  class WorkoutsController < ApiController
    before_action :authorize_request
    before_action :set_workout, only: [:show, :update, :destroy]

    # GET /workouts
    def index
      @workouts = ::V1::WorkoutSerializer.new(Workout.all)

      render json: @workouts
    end

    # GET /workouts/1
    def show
      render json: ::V1::WorkoutSerializer.new(@workout)
    end

    # POST /workouts
    def create
      @workout = Workout.new(workout_params)

      if @workout.save
        render json: ::V1::WorkoutSerializer.new(@workout), status: :created, location: v1_workout_url(@workout)
      else
        render json: @workout.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /workouts/1
    def update
      if @workout.update(workout_params)
        render json: ::V1::WorkoutSerializer.new(@workout)
      else
        render json: @workout.errors, status: :unprocessable_entity
      end
    end

    # DELETE /workouts/1
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
