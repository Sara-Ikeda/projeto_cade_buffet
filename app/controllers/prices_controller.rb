class PricesController < ApplicationController
  before_action :set_event_check_owner_and_prices_availability
  def new
    @price = Price.new
  end

  def create
    price_params = params.require(:price).permit(:minimum_cost, 
      :add_cost_by_person, :add_cost_by_hour, :weekday)

    @price = @event.prices.create(price_params)
    if @price.save
      redirect_to buffet_path(@event.buffet), notice: "Preços-Base adicionado à #{@event.name}"
    else
      render 'new'
    end
  end

  private

  def set_event_check_owner_and_prices_availability
    @event = Event.find(params[:event_id])
    if @event.buffet.owner != current_owner
      redirect_to root_path, notice: 'Você não tem acesso a esse Buffet!'
    elsif !@event.available_days?
      redirect_to root_path
    end
  end
end