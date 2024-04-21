class BuffetsController < ApplicationController
  skip_before_action :buffet_is_required, only: [:new, :create]
  before_action :authenticate_owner!, only: [:edit, :update, :new, :create]

  def index
    @buffets = Buffet.all
  end

  def show
    @buffet = Buffet.find(params[:id])
  end

  def edit
    @buffet = Buffet.find(params[:id])
    @address = @buffet.address
    if @buffet.owner != current_owner
      redirect_to root_path, notice: 'Você não pode editar esse buffet!'
    end
  end

  def update
    @buffet = Buffet.find(params[:id])
    @address = @buffet.address
    if @buffet.owner != current_owner
      return redirect_to root_path, notice: 'Você não pode editar esse buffet!'
    end

    buffet_params = params.require(:buffet).permit(
      :trade_name, :company_name, :registration_number,
      :telephone, :email, :description, :payment_types)
    address_params = params.require(:address).permit(
      :street, :number, :district, :city, :state, :zip)
    
    @address.update(address_params)               # => VERIFICAR!!!
    if @buffet.update(buffet_params)
      redirect_to buffet_path(@buffet), notice: 'Buffet atualizado com sucesso!'
    else
      render 'edit'
    end
  end

  def new
    @buffet = Buffet.new
    @address = @buffet.build_address
  end

  def create
    address_params = params.require(:address).permit(
      :street, :number, :district, :city, :state, :zip)
    buffet_params = params.require(:buffet).permit(
      :trade_name, :company_name, :registration_number,
      :telephone, :email, :description, :payment_types)
    
    @buffet = Buffet.new(buffet_params)
    @buffet.build_address(address_params)
    @buffet.owner = current_owner
    
    if @buffet.save
      redirect_to @buffet, notice: "Buffet cadastrado com sucesso!"
    else
      render 'new'
    end
  end
end