class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    event_params = params.require(:event).permit(:name, :event_description, :minimum_of_people,
    :maximum_of_people, :duration, :menu, :alcoholic_drink, :ornamentation, :valet, :locality)

    @event = current_owner.buffet.events.create(event_params)
    if @event.save
      redirect_to @event.buffet, notice: 'Evento adicionado com sucesso!'
    else
    render 'new'
    end
  end

  def edit
    @event = current_owner.buffet.events.find(params[:id])
  end

  def update
    @event = current_owner.buffet.events.find(params[:id])

    event_params = params.require(:event).permit(:name, :event_description, :minimum_of_people,
    :maximum_of_people, :duration, :menu, :alcoholic_drink, :ornamentation, :valet, :locality)

    if @event.update(event_params)
      redirect_to root_path, notice: 'Evento editado com sucesso!'
    else
      render 'edit'
    end
  end

end