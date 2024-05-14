class ApplicationController < ActionController::API
  before_action :ensure_json_request

  private
  
  def ensure_json_request
    return if request.headers["Accept"]&.include?("application/vnd.api+json")
    head :not_acceptable
  end
end
