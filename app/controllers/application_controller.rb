class ApplicationController < ActionController::API
  before_action :ensure_json_request, except: [:show, :index]
  def ensure_json_request
    unless request.headers["Accept"].include?("application/json")
      render json: { error: "Tipo de conteúdo não suportado" }, status: :not_acceptable
    end
  end
end
