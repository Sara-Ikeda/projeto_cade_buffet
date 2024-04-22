class PricesController < ApplicationController
  def new
    @price = Price.new
  end

  def create
    @price = Price.last

    price_params = params.require(:price).permit(:minimum_cost, 
      :add_cost_by_person, :add_cost_by_hour, :weekday)

    
    @price.minimum_cost = price_params[:minimum_cost]
    @price.add_cost_by_person = price_params[:add_cost_by_person]
    @price.add_cost_by_hour = price_params[:add_cost_by_hour]
    @price.weekday = price_params[:weekday]

    if @price.save
      redirect_to event_path(@price.event), notice: 'Preços-Base adicionado à Festa de Casamento'
    else
      render 'new'
    end
  end
end