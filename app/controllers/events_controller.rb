# require 'time'
# require "active_support/all"
require "net/http"

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  def getapi
    uri = URI('https://maps.googleapis.com/maps/api/place/findplacefromtext/json')
    apiKey = "AIzaSyAmlsvjUNhN1BUTmvSq9SKhq8b0r4qXwAc"
    
    params = { :input => inputText, :inputtype => textquery, :fields => formatted_address, :key => apiKey }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    render json: res.body if res.is_a?(Net::HTTPSuccess)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = parse_event_to_local_time(Event.new(event_params))

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def parse_event_to_local_time (event) 
      event.start_time = parse_time_to_singapore(event.start_time)
      event.end_time = parse_time_to_singapore(event.end_time)
      event
    end

    def parse_time_to_singapore (time)
      time - 8.hours
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :capacity, :location, :start_time, :end_time, :min_pets, :pet_ids => [])
    end
end
