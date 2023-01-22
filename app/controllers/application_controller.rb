class ApplicationController < ActionController::API

  def not_found
    redirect_to root_path
    #render json: { error: 'Not Found 404' }
  end
    
  def authorize_request
    header = request.headers['Authentication']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: "Unauthorized" }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: "Unauthorized" }, status: :unauthorized
    end
  end    
end
