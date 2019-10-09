class ApplicationController < ActionController::API

  include ActionController::Serialization
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error


  def not_found_error
    render json: "Record was not found", status: :not_found
  end

end
