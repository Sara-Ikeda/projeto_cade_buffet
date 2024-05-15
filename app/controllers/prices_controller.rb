class PricesController < ApplicationController
  before_action :set_event_check_owner_and_prices_availability, only: [:new, :create]
  before_action :set_event_and_price_and_available_days_for_edit, only: [:edit, :update]

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

  def edit

  end

  def update
    price_params = params.require(:price).permit(:minimum_cost, 
      :add_cost_by_person, :add_cost_by_hour, :weekday)

    if @price.update(price_params)
      redirect_to root_path, notice: 'Preço-Base editado com sucesso!'
    else
      render 'edit'
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

  def set_event_and_price_and_available_days_for_edit
    @event = current_owner.buffet.events.find(params[:event_id])
    @price = @event.prices.find(params[:id])
    @available_days_for_edit = []
    if @price.weekday == 'Fim de semana' || !@event.prices.where(weekday: 'Fim de Semana').exists?
      @available_days_for_edit << 'Fim de Semana'
    elsif @price.weekday == 'Dias Úteis' || !@event.prices.where(weekday: 'Dias Úteis').exists?
      @available_days_for_edit << 'Dias Úteis'
    end
  end
end