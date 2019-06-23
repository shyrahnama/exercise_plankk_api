class ApplicationController < ActionController::API
  include APIErrorResponses

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JWT.decode(header, nil, false)
      @current_user = @decoded[0]['name'] 
      # @current_user = User.find_by(user_id: @decoded[:user_id])
	    # rescue ActiveRecord::RecordNotFound => e
 	    #   render json: { errors: e.message }, status: :unauthorized

 	    # temporary, just to test a different Auth header
 	    if @current_user != 'plankk_api_client'
 	    	render json: { errors: 'unauthorized JWT token' }, status: :unauthorized
 	    end 
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
