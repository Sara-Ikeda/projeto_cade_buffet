class BuffetsController < ApplicationController
  skip_before_action :buffet_is_required, only: [:new, :create]

  def index
    @buffets = Buffet.all
  end

  def show
    @buffet = Buffet.find(params[:id])
  end

  def edit
    @buffet = Buffet.find(params[:id])
    @address = Address.find(@buffet.address_id)
  end

  def update
    @buffet = Buffet.find(params[:id])

    buffet_params = params.require(:buffet).permit(
      :trade_name, :telephone, :email, :payment_types, :description, :address)
    
    if @buffet.update(buffet_params)
      redirect_to buffet_path(@buffet), notice: 'Buffet atualizado com sucesso!'
    else
      render 'edit'
    end
  end

  def new
    @buffet = Buffet.new
    @address = Address.new
  end

  def create
    address_params = params.require(:address).permit(
      :street, :number, :district, :city, :state, :zip)
    @address = Address.create!(address_params)

    buffet_params = params.require(:buffet).permit(
      :trade_name, :company_name, :registration_number,
      :telephone, :email, :description, :payment_types)
    
    @buffet = Buffet.new(buffet_params)
    @buffet.address = @address
    @buffet.owner = current_owner

    if @buffet.save
      redirect_to @buffet, notice: "Buffet cadastrado com sucesso!"
    else
      render 'new'
    end
  end
end