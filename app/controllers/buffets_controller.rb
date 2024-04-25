class BuffetsController < ApplicationController
  skip_before_action :buffet_is_required, only: [:new, :create, :search]
  skip_before_action :authenticate_owner!, only: [:index, :show, :search]

  def index
    redirect_to current_owner.buffet if owner_signed_in?
    @buffets = Buffet.all
  end

  def show
    @buffet = Buffet.find(params[:id])
    redirect_to current_owner.buffet if owner_signed_in? && @buffet != current_owner.buffet
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
    
    @buffet = current_owner.build_buffet(buffet_params)
    @buffet.build_address(address_params)
    
    if @buffet.save
      redirect_to @buffet, notice: "Buffet cadastrado com sucesso!"
    else
      render 'new'
    end
  end

  def search
    @query = params[:query]
    @search_buffets = Buffet.left_joins(:address, :events).where("trade_name LIKE '%#{@query}%'").or(
                      Buffet.where(address: { city: @query})).or(
                      Buffet.where("events.name LIKE ?", "%#{@query}%")).order(trade_name: :asc)
    @count = @search_buffets.count
  end
end