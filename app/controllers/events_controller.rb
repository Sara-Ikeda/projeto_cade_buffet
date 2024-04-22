class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    event_params = params.require(:event).permit(:name, :event_description, :minimum_of_people,
    :maximum_of_people, :duration, :menu, :alcoholic_drink, :ornamentation, :valet, :locality)

    @event = Event.new(event_params)
    @event.buffet = current_owner.buffet

    if @event.save
      redirect_to @event.buffet, notice: 'Evento adicionado com sucesso!'
    else
      render 'new'
    end
  end
end