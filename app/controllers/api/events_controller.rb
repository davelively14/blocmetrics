class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :set_access_control_headers

  # Set CORS response headers. Permits POST requests across all domains.
  def set_access_control_headers
    # Permits requests from any origin
    headers['Access-Control-Allow-Origin'] = '*'

    # Permits POST, GET, and OPTIONS methods
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'

    # Permits HTTP header Content-Type, which is used by HTTP requests to
    # declare the type of data being sent.
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end

  def create
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])

    if registered_application
      @event = Event.new(event_params)
      @event.registered_application = registered_application

      @event.save ? render(json: @event, status: :created) : render(json: {errors: @event.errors}, status: :unprocessable_entity)
    else
      render json: "Unregistered application", status: :unprocessable_entity
    end
  end

  # Returns a 200 status in response to a an HTTP options request
  def preflight
    head 200
  end

  private

  def event_params
    params.require(:event).permit(:name)
  end
end
