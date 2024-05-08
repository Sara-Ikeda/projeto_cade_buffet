class Api::V1::EventsController < Api::V1::ApiController
  def index
    events = Buffet.find(params[:buffet_id]).events
    if events.any?
      render status: 200, json: events, except: [:buffet_id, :created_at, :updated_at]
    else
      render status: 204
    end
  end

  def query
    @event = Event.find(params[:id])
    @query_params = params.permit(:date, :number_of_guests)
    if @query_params[:date].nil? || @query_params[:number_of_guests].nil?
      render status: 400, json: {error: 'Número errado de argumentos.'}
    else
      if @event.buffet.orders.where(date: @query_params[:date]).exists? && @query_params[:date].to_date > Date.today
        render status: 406, json: {error: 'Data indisponível!'}
      else
        standard_value = calculate_standard_value
        render status: 200, json: { standard_value: standard_value }
      end
    end
  end

  private

  def calculate_standard_value
    if @query_params[:date].to_date.on_weekday?
      price = @event.prices.find_by!(weekday: 'Dias Úteis')
    else
      price = @event.prices.find_by!(weekday: 'Fim de Semana')
    end
    if @query_params[:number_of_guests].to_i > @event.minimum_of_people
      return (@query_params[:number_of_guests].to_i - @event.minimum_of_people
             )*price.add_cost_by_person + price.minimum_cost
    else
      return price.minimum_cost
    end
  end
end