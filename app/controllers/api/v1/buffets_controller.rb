class Api::V1::BuffetsController < ActionController::API
  def index
    begin
      buffets = Buffet.all
      if buffets.any?
        render status: 200, json: buffets, only: [:id, :trade_name]
      else
        render status: 204
      end
    rescue
      render status: 500
    end
  end
end