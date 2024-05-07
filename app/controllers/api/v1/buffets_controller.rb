class Api::V1::BuffetsController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500
  rescue_from ActiveRecord::RecordNotFound, with: :return_404

  def index
    buffets = Buffet.all
    if buffets.any?
      render status: 200, json: buffets, only: [:id, :trade_name]
    else
      render status: 204
    end
  end

  def show
    buffet = Buffet.find(params[:id])
    render status: 200, json: buffet, only: [:id, :trade_name, :telephone, :email, :description, :payment_types],
                              include: {address: {only: [:street, :number, :district, :district,:city, :state, :zip]}}
  end

  private

  def return_404
    render status: 404
  end

  def return_500
    render status: 500
  end
end