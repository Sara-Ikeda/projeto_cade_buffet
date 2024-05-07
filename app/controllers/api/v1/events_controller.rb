class Api::V1::EventsController < Api::V1::ApiController
  def index
    events = Buffet.find(params[:buffet_id]).events
    if events.any?
      render status: 200, json: events, except: [:id, :buffet_id, :created_at, :updated_at]
    else
      render status: 204
    end
  end
end