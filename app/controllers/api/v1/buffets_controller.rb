class Api::V1::BuffetsController < Api::V1::ApiController
  def index
    search = params.permit(:search)
    if search.present?
      buffets = Buffet.where("trade_name LIKE '%#{search[:search]}%'")
    else
      buffets = Buffet.all
    end
    if buffets.any?
      render status: 200, json: buffets, only: [:id, :trade_name], methods: [:contact]
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