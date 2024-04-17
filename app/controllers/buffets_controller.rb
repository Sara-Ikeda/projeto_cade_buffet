class BuffetsController < ApplicationController
  def index
    @buffets = Buffet.all
  end

  def show
    @buffet = Buffet.find(params[:id])
  end

  def edit
    @buffet = Buffet.find(params[:id])
  end

  def update
    @buffet = Buffet.find(params[:id])

    buffet_params = params.require(:buffet).permit(
      :trade_name, :telephone, :email, :payment_types, :description, :address)
    
    if @buffet.update(buffet_params)
      redirect_to buffet_path(@buffet.id), notice: 'Buffet atualizado com sucesso!'
    else
      render 'edit'
    end
  end
end