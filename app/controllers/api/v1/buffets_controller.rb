class Api::V1::BuffetsController < Api::V1::ApiController
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
end